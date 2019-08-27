//
//  LoggerManager.swift
//  TestCocoaLumberjack
//
//  Created by zero on 2019/8/14.
//  Copyright © 2019 hsj. All rights reserved.
//

import UIKit
import CocoaLumberjack

class LoggerManager {
    static let shared = LoggerManager()

    lazy private var fileLogger: DDFileLogger = {
        let logger = DDFileLogger()
        logger.maximumFileSize = 100*1024
        logger.logFileManager.maximumNumberOfLogFiles = 10
        return logger
    }()

    var logPaths: [String] {
        return fileLogger.logFileManager.sortedLogFilePaths
    }

    func config() {
        DDLog.add(DDOSLogger.sharedInstance)
        DDLog.add(fileLogger)
    }

    func deleteLog(_ path: String) {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print(error.localizedDescription)
        }
    }

}
