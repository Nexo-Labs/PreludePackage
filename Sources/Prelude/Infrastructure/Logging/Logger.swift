//
//  Logging.swift
//  SyncTion (macOS)
//
//  Created by Rubén on 26/12/22.
//

import Foundation

public enum LogLevel: String {
    case DEBUG = "🔵"
    case INFO = "🟢"
    case DEFAULT = "🟡"
    case ERROR = "🔴"
    case FAULT = "⚫️"
}

public protocol LoggerStrategy {
    func log(_ object: Any..., separator: String, terminator: String, level: LogLevel)
}

public struct Logger {
    let strategy: LoggerStrategy
    
    public func debug(_ object: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
        strategy.log(object(), separator: separator, terminator: terminator, level: .DEBUG)
    }

    public func debugs(_ objects: Any..., separator: String = " ", terminator: String = "\n") {
        strategy.log(objects, separator: separator, terminator: terminator, level: .DEBUG)
    }

    public func info(_ object: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
        strategy.log(object(), separator: separator, terminator: terminator, level: .INFO)
    }

    public func infos(_ objects: Any..., separator: String = " ", terminator: String = "\n") {
        strategy.log(objects, separator: separator, terminator: terminator, level: .INFO)
    }

    public func warning(_ object: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
        strategy.log(object(), separator: separator, terminator: terminator, level: .DEFAULT)
    }
    
    public func warnings(_ objects: Any..., separator: String = " ", terminator: String = "\n") {
        strategy.log(objects, separator: separator, terminator: terminator, level: .DEFAULT)
    }

    public func error(_ object: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
        strategy.log(object(), separator: separator, terminator: terminator, level: .ERROR)
    }
    
    public func errors(_ objects: Any..., separator: String = " ", terminator: String = "\n") {
        strategy.log(objects, separator: separator, terminator: terminator, level: .ERROR)
    }

    public func critical(_ object: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
        strategy.log(object(), separator: separator, terminator: terminator, level: .FAULT)
    }
    
    public func criticals(_ objects: Any..., separator: String = " ", terminator: String = "\n") {
        strategy.log(objects, separator: separator, terminator: terminator, level: .FAULT)
    }
}

extension Logger {
    static let `default` = Logger(strategy: .default)
}

