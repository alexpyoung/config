"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const fs = require("fs");
const bibEntries = ['article', 'book', 'bookinbook', 'booklet', 'collection', 'conference', 'inbook',
    'incollection', 'inproceedings', 'inreference', 'manual', 'mastersthesis', 'misc',
    'mvbook', 'mvcollection', 'mvproceedings', 'mvreference', 'online', 'patent', 'periodical',
    'phdthesis', 'proceedings', 'reference', 'report', 'set', 'suppbook', 'suppcollection',
    'suppperiodical', 'techreport', 'thesis', 'unpublished'];
class Citation {
    constructor(extension) {
        this.citationInBib = {};
        this.citationData = {};
        this.theBibliographyData = {};
        this.extension = extension;
    }
    reset() {
        this.suggestions = [];
        this.theBibliographyData = {};
        this.refreshTimer = 0;
    }
    provide(args) {
        if (Date.now() - this.refreshTimer < 1000) {
            return this.suggestions;
        }
        this.refreshTimer = Date.now();
        const configuration = vscode.workspace.getConfiguration('latex-workshop');
        const rootFile = this.extension.manager.rootFile;
        // First, we deal with citation items from bib files
        const items = [];
        Object.keys(this.citationInBib).forEach(bibPath => {
            if (this.citationInBib[bibPath].rootFiles.length === 0 || this.citationInBib[bibPath].rootFiles.indexOf(rootFile) > -1) {
                this.citationInBib[bibPath].citations.forEach(item => items.push(item));
            }
        });
        this.suggestions = items.map(item => {
            const citation = new vscode.CompletionItem(item.key, vscode.CompletionItemKind.Reference);
            citation.detail = item.title;
            switch (configuration.get('intellisense.citation.label')) {
                case 'bibtex key':
                default:
                    citation.label = item.key;
                    break;
                case 'title':
                    if (item.title) {
                        citation.label = item.title;
                        citation.detail = undefined;
                    }
                    else {
                        citation.label = item.key;
                    }
                    break;
                case 'authors':
                    if (item.author) {
                        citation.label = item.author;
                        citation.detail = undefined;
                    }
                    else {
                        citation.label = item.key;
                    }
                    break;
            }
            citation.filterText = `${item.key} ${item.author} ${item.title} ${item.journal}`;
            citation.insertText = item.key;
            citation.documentation = Object.keys(item)
                .filter(key => (key !== 'key'))
                .map(key => `${key}: ${item[key]}`)
                .join('\n');
            if (args) {
                citation.range = args.document.getWordRangeAtPosition(args.position, /[-a-zA-Z0-9_:\.]+/);
            }
            return citation;
        });
        // Second, we deal with the items from thebibliography
        const suggestions = {};
        Object.keys(this.theBibliographyData).forEach(key => {
            if (!(this.theBibliographyData[key].rootFile === rootFile)) {
                return;
            }
            suggestions[key] = this.theBibliographyData[key].item;
        });
        if (vscode.window.activeTextEditor) {
            const thebibliographyItems = this.getTheBibliographyItems(vscode.window.activeTextEditor.document.getText());
            Object.keys(thebibliographyItems).map(key => {
                if (!(key in suggestions)) {
                    suggestions[key] = thebibliographyItems[key];
                }
            });
        }
        Object.keys(suggestions).map(key => {
            const item = suggestions[key];
            const citation = new vscode.CompletionItem(item.citation, vscode.CompletionItemKind.Reference);
            citation.detail = item.text;
            if (args) {
                citation.range = args.document.getWordRangeAtPosition(args.position, /[-a-zA-Z0-9_:\.]+/);
            }
            this.suggestions.push(citation);
        });
        return this.suggestions;
    }
    browser(args) {
        this.provide(args);
        const items = [];
        Object.keys(this.citationInBib).forEach(bibPath => {
            this.citationInBib[bibPath].citations.forEach(item => items.push(item));
        });
        const pickItems = items.map(item => {
            return {
                label: item.title ? item.title : '',
                description: `${item.key}`,
                detail: `Authors: ${item.author ? item.author : 'Unknown'}, publication: ${item.journal ? item.journal : (item.publisher ? item.publisher : 'Unknown')}`
            };
        });
        vscode.window.showQuickPick(pickItems, {
            placeHolder: 'Press ENTER to insert citation key at cursor',
            matchOnDetail: true,
            matchOnDescription: true
        }).then(selected => {
            if (!selected) {
                return;
            }
            if (vscode.window.activeTextEditor) {
                const editor = vscode.window.activeTextEditor;
                const content = editor.document.getText(new vscode.Range(new vscode.Position(0, 0), editor.selection.start));
                let start = editor.selection.start;
                if (content.lastIndexOf('\\cite') > content.lastIndexOf('}')) {
                    const curlyStart = content.lastIndexOf('{') + 1;
                    const commaStart = content.lastIndexOf(',') + 1;
                    start = editor.document.positionAt(curlyStart > commaStart ? curlyStart : commaStart);
                }
                editor.edit(edit => edit.replace(new vscode.Range(start, editor.selection.start), selected.description || ''))
                    .then(() => editor.selection = new vscode.Selection(editor.selection.end, editor.selection.end));
            }
        });
    }
    parseBibFile(bibPath, texFile = undefined) {
        this.extension.logger.addLogMessage(`Parsing .bib entries from ${bibPath}`);
        const items = [];
        const configuration = vscode.workspace.getConfiguration('latex-workshop');
        if (fs.statSync(bibPath).size >= configuration.get('intellisense.citation.maxfilesizeMB') * 1024 * 1024) {
            this.extension.logger.addLogMessage(`${bibPath} is too large, ignoring it.`);
            this.citationInBib[bibPath] = { citations: items, rootFiles: [] };
            return;
        }
        const content = fs.readFileSync(bibPath, 'utf-8');
        const contentNoNewLine = content.replace(/[\r\n]/g, ' ');
        const itemReg = /@(\w+)\s*{/g;
        let result = itemReg.exec(contentNoNewLine);
        let prevResult = null;
        let numLines = 1;
        let prevPrevResultIndex = 0;
        while (result || prevResult) {
            if (prevResult && bibEntries.indexOf(prevResult[1].toLowerCase()) > -1) {
                const itemString = contentNoNewLine.substring(prevResult.index, result ? result.index : undefined).trim();
                const item = this.parseBibString(itemString);
                if (item !== undefined) {
                    items.push(item);
                    numLines = numLines + content.substring(prevPrevResultIndex, prevResult.index).split('\n').length - 1;
                    prevPrevResultIndex = prevResult.index;
                    this.citationData[item.key] = {
                        item,
                        text: Object.keys(item)
                            .filter(key => (key !== 'key'))
                            .sort((a, b) => {
                            if (a.toLowerCase() === 'title') {
                                return -1;
                            }
                            if (b.toLowerCase() === 'title') {
                                return 1;
                            }
                            if (a.toLowerCase() === 'author') {
                                return -1;
                            }
                            if (b.toLowerCase() === 'author') {
                                return 1;
                            }
                            return 0;
                        })
                            .map(key => `${key}: ${item[key]}`)
                            .join('\n\n'),
                        position: new vscode.Position(numLines - 1, 0),
                        file: bibPath
                    };
                }
                else {
                    // TODO we could consider adding a diagnostic for this case so the issue appears in the Problems list
                    this.extension.logger.addLogMessage(`Warning - following .bib entry in ${bibPath} has no cite key:\n${itemString}`);
                }
            }
            prevResult = result;
            if (result) {
                result = itemReg.exec(contentNoNewLine);
            }
        }
        this.extension.logger.addLogMessage(`Parsed ${items.length} .bib entries from ${bibPath}.`);
        let rootFilesList = [];
        if (bibPath in this.citationInBib) {
            rootFilesList = this.citationInBib[bibPath].rootFiles;
        }
        if (texFile && rootFilesList.indexOf(texFile) === -1) {
            rootFilesList.push(texFile);
        }
        this.citationInBib[bibPath] = { citations: items, rootFiles: rootFilesList };
    }
    forgetParsedBibItems(bibPath) {
        this.extension.logger.addLogMessage(`Forgetting parsed bib entries for ${bibPath}`);
        delete this.citationInBib[bibPath];
    }
    parseBibString(item) {
        const bibDefinitionReg = /((@)[a-zA-Z]+)\s*(\{)\s*([^\s,]*)/g;
        let regResult = bibDefinitionReg.exec(item);
        if (!regResult) {
            return undefined;
        }
        item = item.substr(bibDefinitionReg.lastIndex);
        const bibItem = { key: regResult[4] };
        const bibAttrReg = /([a-zA-Z0-9\!\$\&\*\+\-\.\/\:\;\<\>\?\[\]\^\_\`\|]+)\s*(\=)/g;
        regResult = bibAttrReg.exec(item);
        while (regResult) {
            const attrKey = regResult[1];
            item = item.substr(bibAttrReg.lastIndex);
            bibAttrReg.lastIndex = 0;
            const commaPos = /,/g.exec(item);
            const quotePos = /\"/g.exec(item);
            const bracePos = /{/g.exec(item);
            let attrValue = '';
            if (commaPos && ((!quotePos || (quotePos && (commaPos.index < quotePos.index)))
                && (!bracePos || (bracePos && (commaPos.index < bracePos.index))))) {
                // No deliminator
                attrValue = item.substring(0, commaPos.index).trim();
                item = item.substr(commaPos.index);
            }
            else if (bracePos && (!quotePos || quotePos.index > bracePos.index)) {
                // Use curly braces
                let nested = 0;
                for (let i = bracePos.index; i < item.length; ++i) {
                    const char = item[i];
                    if (char === '{' && item[i - 1] !== '\\') {
                        nested++;
                    }
                    else if (char === '}' && item[i - 1] !== '\\') {
                        nested--;
                    }
                    if (nested === 0) {
                        attrValue = item.substring(bracePos.index + 1, i)
                            .replace(/(\\.)|({)/g, '$1').replace(/(\\.)|(})/g, '$1');
                        item = item.substr(i);
                        break;
                    }
                }
            }
            else if (quotePos) {
                // Use double quotes
                for (let i = quotePos.index + 1; i < item.length; ++i) {
                    if (item[i] === '"') {
                        attrValue = item.substring(quotePos.index + 1, i)
                            .replace(/(\\.)|({)/g, '$1').replace(/(\\.)|(})/g, '$1');
                        item = item.substr(i);
                        break;
                    }
                }
            }
            bibItem[attrKey.toLowerCase()] = attrValue;
            regResult = bibAttrReg.exec(item);
        }
        return bibItem;
    }
    getTheBibliographyTeX(filePath) {
        const bibitems = this.getTheBibliographyItems(fs.readFileSync(filePath, 'utf-8'));
        Object.keys(this.theBibliographyData).forEach((key) => {
            if (this.theBibliographyData[key].file === filePath) {
                delete this.theBibliographyData[key];
            }
        });
        Object.keys(bibitems).forEach((key) => {
            this.theBibliographyData[key] = {
                item: bibitems[key],
                text: bibitems[key].text,
                file: filePath,
                rootFile: this.extension.manager.rootFile
            };
        });
    }
    getTheBibliographyItems(content) {
        const itemReg = /^(?!%).*\\bibitem(?:\[[^\[\]\{\}]*\])?{([^}]*)}/gm;
        const items = {};
        while (true) {
            const result = itemReg.exec(content);
            if (result === null) {
                break;
            }
            if (!(result[1] in items)) {
                const postContent = content.substring(result.index + result[0].length, content.indexOf('\n', result.index)).trim();
                const positionContent = content.substring(0, result.index).split('\n');
                items[result[1]] = {
                    citation: result[1],
                    text: `${postContent}\n...`,
                    position: new vscode.Position(positionContent.length - 1, positionContent[positionContent.length - 1].length)
                };
            }
        }
        return items;
    }
}
exports.Citation = Citation;
//# sourceMappingURL=citation.js.map