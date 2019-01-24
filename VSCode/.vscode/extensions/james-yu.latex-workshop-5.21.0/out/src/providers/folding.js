"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
class FoldingProvider {
    constructor(extension) {
        this.sectionRegex = [];
        this.extension = extension;
        const sections = vscode.workspace.getConfiguration('latex-workshop').get('view.outline.sections');
        this.sectionRegex = sections.map(section => RegExp(`\\\\${section}(?:\\*)?(?:\\[[^\\[\\]\\{\\}]*\\])?{(.*)}`, 'm'));
    }
    provideFoldingRanges(document, _context, _token) {
        return [...this.getSectionFoldingRanges(document), ...this.getEnvironmentFoldingRanges(document)];
    }
    getSectionFoldingRanges(document) {
        const startingIndices = this.sectionRegex.map(_ => -1);
        const lines = document.getText().split(/\r?\n/g);
        let documentClassLine = -1;
        const sections = [];
        for (const line of lines) {
            const index = lines.indexOf(line);
            for (const regex of this.sectionRegex) {
                const result = regex.exec(line);
                if (!result) {
                    continue;
                }
                const regIndex = this.sectionRegex.indexOf(regex);
                const originalIndex = startingIndices[regIndex];
                if (originalIndex === -1) {
                    startingIndices[regIndex] = index;
                    continue;
                }
                let i = regIndex;
                while (i < this.sectionRegex.length) {
                    sections.push({
                        level: i,
                        from: startingIndices[i],
                        to: index - 1
                    });
                    startingIndices[i] = regIndex === i ? index : -1;
                    ++i;
                }
            }
            if (/\\documentclass/.exec(line)) {
                documentClassLine = index;
            }
            if (/\\begin{document}/.exec(line) && documentClassLine > -1) {
                sections.push({
                    level: 0,
                    from: documentClassLine,
                    to: index - 1
                });
            }
            if (/\\end{document}/.exec(line) || index === lines.length - 1) {
                for (let i = 0; i < startingIndices.length; ++i) {
                    if (startingIndices[i] === -1) {
                        continue;
                    }
                    sections.push({
                        level: i,
                        from: startingIndices[i],
                        to: index - 1
                    });
                }
            }
        }
        return sections.map(section => new vscode.FoldingRange(section.from, section.to));
    }
    getEnvironmentFoldingRanges(document) {
        const ranges = [];
        const opStack = [];
        const text = document.getText();
        const envRegex = /(?:\\(begin){(.*?)})|(?:\\(begingroup)(?=$|%|\s|\\))|(?:\\(end){(.*?)})|(?:\\(endgroup)(?=$|%|\s|\\))/g; //to match one 'begin' OR 'end'
        let match = envRegex.exec(text); // init regex search
        while (match) {
            //for 'begin': match[1] contains 'begin', match[2] contains keyword
            //for 'end':   match[4] contains 'end',   match[5] contains keyword
            //for 'begingroup': match[3] contains 'begingroup', keyword is 'group'
            //for 'endgroup': match[6] contains 'begingroup', keyword is 'group'
            const item = {
                keyword: match[1] ? match[2] : (match[3] ? 'group' : (match[4] ? match[5] : 'group')),
                index: match.index
            };
            const lastItem = opStack[opStack.length - 1];
            if ((match[4] || match[6]) && lastItem && lastItem.keyword === item.keyword) { // match 'end' with its 'begin'
                opStack.pop();
                ranges.push(new vscode.FoldingRange(document.positionAt(lastItem.index).line, document.positionAt(item.index).line - 1));
            }
            else {
                opStack.push(item);
            }
            match = envRegex.exec(text); //iterate regex search
        }
        //TODO: if opStack still not empty
        return ranges;
    }
}
exports.FoldingProvider = FoldingProvider;
//# sourceMappingURL=folding.js.map