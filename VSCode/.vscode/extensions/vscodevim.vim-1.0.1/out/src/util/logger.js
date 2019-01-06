"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const TransportStream = require("winston-transport");
const vscode = require("vscode");
const winston = require("winston");
const winston_console_for_electron_1 = require("winston-console-for-electron");
const configuration_1 = require("../configuration/configuration");
/**
 * Implementation of Winston transport
 * Displays VS Code message to user
 */
class VsCodeMessage extends TransportStream {
    log(info, callback) {
        switch (info.level) {
            case 'error':
                vscode.window.showErrorMessage(info.message, 'Dismiss');
                break;
            case 'warn':
                vscode.window.showWarningMessage(info.message, 'Dismiss');
                break;
            case 'info':
            case 'verbose':
            case 'debug':
                vscode.window.showInformationMessage(info.message, 'Dismiss');
                break;
        }
        if (callback) {
            callback();
        }
    }
}
exports.logger = winston.createLogger({
    format: winston.format.simple(),
    transports: [
        new winston_console_for_electron_1.ConsoleForElectron({
            level: configuration_1.configuration.debug.loggingLevelForConsole,
            silent: configuration_1.configuration.debug.silent,
        }),
        new VsCodeMessage({
            level: configuration_1.configuration.debug.loggingLevelForAlert,
            silent: configuration_1.configuration.debug.silent,
        }),
    ],
});

//# sourceMappingURL=logger.js.map
