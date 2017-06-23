//
//  Logger.swift
//  MustSiri
//
//  Created by Вадим on 23/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

class Logger: NSObject {
    static func logs() -> String {
        var dump = ""
        
        if let docsPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.aximedia.mustsiri") {
            let path = docsPath.appendingPathComponent("log.txt").path
            
            if FileManager.default.fileExists(atPath: path) {
                dump =  try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
            }
        }
        
        return dump
    }
    
    static func println(_ items: Any..., separator: String = ",", terminator: String = ";") {
        if let docsPath = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.aximedia.mustsiri") {
            let path = docsPath.appendingPathComponent("log.txt").path
            
            if !FileManager.default.fileExists(atPath: path) {
                NSData.init().write(toFile: path, atomically: true)
            }
            
            let handle = FileHandle.init(forWritingAtPath: path)
            handle?.truncateFile(atOffset: (handle?.seekToEndOfFile())!)
            handle?.write("\n\(items)".data(using: String.Encoding.utf8)!)
            handle?.closeFile()

        }
    }
}
