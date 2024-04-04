//
//  OSLogStrategy.swift
//
//
//  Created by Rubén García Hernando on 4/4/24.
//

#if canImport(os.log)
import os.log
import Foundation

public extension os.Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let main = os.Logger(subsystem: subsystem, category: "main")
}

extension Logger {
    static let osLog = Logger(strategy: .osLog)
}


public extension SimpleLoggerStrategy {
    static let osLog = Self { object, separator, terminator, level in
        os.Logger.main.log(level: level.osLog, "\(level.rawValue) \(String(describing: object))")
    }
}

extension LogLevel {
    var osLog: OSLogType {
        switch self {
        case .DEBUG:
            return OSLogType.debug
        case .INFO:
            return OSLogType.info
        case .DEFAULT:
            return OSLogType.default
        case .ERROR:
            return OSLogType.error
        case .FAULT:
            return OSLogType.fault
        }
    }
}

#endif
