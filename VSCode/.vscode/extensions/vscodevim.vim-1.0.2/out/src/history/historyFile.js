"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs = require("fs");
const path = require("path");
const util_1 = require("util");
const configuration_1 = require("../configuration/configuration");
const logger_1 = require("../util/logger");
const util_2 = require("../util/util");
const mkdirp = require('mkdirp');
class HistoryFile {
    constructor(historyFileName, historyDir) {
        this._history = [];
        this._historyFileName = historyFileName;
        this._historyDir = historyDir ? historyDir : util_2.getExtensionDirPath();
    }
    get historyFilePath() {
        return path.join(this._historyDir, this._historyFileName);
    }
    add(value) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!value || value.length === 0) {
                return;
            }
            // remove duplicates
            let index = this._history.indexOf(value);
            if (index !== -1) {
                this._history.splice(index, 1);
            }
            // append to the end
            this._history.push(value);
            // resize array if necessary
            if (this._history.length > configuration_1.configuration.history) {
                this._history = this._history.slice(this._history.length - configuration_1.configuration.history);
            }
            return this.save();
        });
    }
    get() {
        // resize array if necessary
        if (this._history.length > configuration_1.configuration.history) {
            this._history = this._history.slice(this._history.length - configuration_1.configuration.history);
        }
        return this._history;
    }
    clear() {
        try {
            this._history = [];
            fs.unlinkSync(this.historyFilePath);
        }
        catch (err) {
            logger_1.logger.warn(`historyFile: Unable to delete ${this.historyFilePath}. err=${err}.`);
        }
    }
    load() {
        return __awaiter(this, void 0, void 0, function* () {
            let data = '';
            try {
                data = yield util_1.promisify(fs.readFile)(this.historyFilePath, 'utf-8');
            }
            catch (err) {
                if (err.code === 'ENOENT') {
                    logger_1.logger.debug(`historyFile: History does not exist. path=${this._historyDir}`);
                }
                else {
                    logger_1.logger.warn(`historyFile: Failed to load history. path=${this._historyDir} err=${err}.`);
                }
                return;
            }
            if (data.length === 0) {
                return;
            }
            try {
                let parsedData = JSON.parse(data);
                if (!Array.isArray(parsedData)) {
                    throw Error('Unexpected format in history file. Expected JSON.');
                }
                this._history = parsedData;
            }
            catch (e) {
                logger_1.logger.warn(`historyFile: Deleting corrupted history file. path=${this._historyDir} err=${e}.`);
                this.clear();
            }
        });
    }
    save() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                // create supplied directory. if directory already exists, do nothing.
                yield util_1.promisify(mkdirp)(this._historyDir, 0o775);
                // create file
                yield util_1.promisify(fs.writeFile)(this.historyFilePath, JSON.stringify(this._history), 'utf-8');
            }
            catch (err) {
                logger_1.logger.error(`historyFile: Failed to save history. filepath=${this.historyFilePath}. err=${err}.`);
                throw err;
            }
        });
    }
}
exports.HistoryFile = HistoryFile;
class SearchHistory extends HistoryFile {
    constructor(historyFileDir) {
        super('.search_history', historyFileDir);
    }
}
exports.SearchHistory = SearchHistory;
class CommandLineHistory extends HistoryFile {
    constructor(historyFileDir) {
        super('.cmdline_history', historyFileDir);
    }
}
exports.CommandLineHistory = CommandLineHistory;

//# sourceMappingURL=historyFile.js.map
