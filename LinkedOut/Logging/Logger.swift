//
//  Logger.swift
//  LinkedOut
//
//  Created by 이상하 on 7/24/24.
//

import CocoaLumberjack
import Then

let LOG_BEGIN = "\n------------------LOG_BEGIN---------------------------------------------------------------------\n"
let LOG_END   = "\n------------------LOG_END-----------------------------------------------------------------------\n"

extension DDLogFlag {
  public var level: String {
    switch self {
    case DDLogFlag.error: return "❤️ ERROR"
    case DDLogFlag.warning: return "💛 WARNING"
    case DDLogFlag.info: return "💙 INFO"
    case DDLogFlag.debug: return "💚 DEBUG"
    case DDLogFlag.verbose: return "💜 VERBOSE"
    default: return "☠️ UNKNOWN"
    }
  }
}

private class LogFormatter: NSObject, DDLogFormatter {

    static let dateFormatter = DateFormatter().then {
    $0.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
  }

  public func format(message logMessage: DDLogMessage) -> String? {
    let timestamp = LogFormatter.dateFormatter.string(from: logMessage.timestamp)
    let level = logMessage.flag.level
    let filename = logMessage.fileName
    let function = logMessage.function ?? ""
    let line = logMessage.line
    let message = logMessage.message.components(separatedBy: "\n").joined(separator: "\n    ")
    return "\(timestamp) \(level) \(filename).\(function):\(line) - \(message)"
  }

  private func formattedDate(from date: Date) -> String {
    return LogFormatter.dateFormatter.string(from: date)
  }

}

/// A shared instance of `Logger`.
public let log = Logger()

public final class Logger {

  // MARK: Initialize

  public init() {
    setenv("XcodeColors", "YES", 0)

    // TTY = Xcode console
    DDTTYLogger.sharedInstance?.do {
      $0.logFormatter = LogFormatter()
      $0.colorsEnabled = false /*true*/ // Note: doesn't work in Xcode 8
      $0.setForegroundColor(DDMakeColor(30, 121, 214), backgroundColor: nil, for: .info)
      $0.setForegroundColor(DDMakeColor(50, 143, 72), backgroundColor: nil, for: .debug)
      DDLog.add($0)
    }

    // File logger
    DDFileLogger().do {
      $0.rollingFrequency = TimeInterval(60 * 60 * 24)  // 24 hours
      $0.logFileManager.maximumNumberOfLogFiles = 7
      DDLog.add($0)
    }
  }


  // MARK: Logging

  public func error(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = LOG_BEGIN + self.message(from: items) + LOG_END
    DDLogError(message, file: file, function: function, line: line)
  }

  public func warning(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = LOG_BEGIN + self.message(from: items) + LOG_END
    DDLogWarn(message, file: file, function: function, line: line)
  }

  public func info(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = LOG_BEGIN + self.message(from: items) + LOG_END
    DDLogInfo(message, file: file, function: function, line: line)
  }

  public func debug(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = LOG_BEGIN + self.message(from: items) + LOG_END
    DDLogDebug(message, file: file, function: function, line: line)
  }

  public func verbose(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = LOG_BEGIN + self.message(from: items) + LOG_END
    DDLogVerbose(message, file: file, function: function, line: line)
  }


  // MARK: Utils

  private func message(from items: [Any]) -> String {
    return items
      .map { String(describing: $0) }
      .joined(separator: " ")
  }

}
