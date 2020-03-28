//
//  Logger.swift
//
//  Created by Benedek Varga on 03/14 W 73.
//  Copyright © 2018. Benedek Varga. All rights reserved.
//
// Poor man's best debugger is print.

import Foundation

public enum LogEvent: String {
    case info = "[ℹ️]"
    case network = "[📡]"
    case debug = "[🐛]"
    case warning = "[⚠️]"
    case error = "[❗️]"
}

/// Provide informative log to console. Default event is `debug` and default isDate is `false`.
public func log(
    _ messageElements: Any...,
    fileName: String = #file,
    line: Int = #line,
    funcName: String = #function,
    event: LogEvent = .debug,
    isDate: Bool = false) {
    let pathComponents = fileName.components(separatedBy: "/")
    let extractedFileName = pathComponents.isEmpty ? "" : pathComponents.last!
    let message = messageElements.map { "\($0)" }.joined(separator: " ")
    print("<\(event.rawValue)> - \(message) - at line \(line) in \(funcName), \(extractedFileName)\(isDate ? " - \(Date().toString())" : "")")
}

public func infoLog(_ messageElements: Any...) {
    logEvent(messageElements, event: .info)
}

public func networkLog(_ messageElements: Any...) {
    logEvent(messageElements, event: .network)
}

public func debugLog(_ messageElements: Any...) {
    logEvent(messageElements, event: .debug)
}

public func warningLog(_ messageElements: Any...) {
    logEvent(messageElements, event: .warning)
}

public func errorLog(_ messageElements: Any...) {
    logEvent(messageElements, event: .error)
}

func logEvent(_ messageElements: Any..., event: LogEvent) {
    let message = messageElements.map { "\($0)" }.joined(separator: " ")
    print("\(event.rawValue) - \(message)")
}

extension Date {
    static var dateFormat = "yyyy.MM.dd hh:mm:ss:SSSS"

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    /// Formats date to `year.month.day hour:minute:sec:milisec`.
    func toString() -> String {
        return Date.dateFormatter.string(from: self as Date)
    }
}
