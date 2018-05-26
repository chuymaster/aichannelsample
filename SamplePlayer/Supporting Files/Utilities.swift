//
//  Utilities.swift
//  SamplePlayer
//
//  Created by CHATCHAI LOKNIYOM on 2018/05/26.
//  Copyright © 2018 Chatchai. All rights reserved.
//

import Foundation

/// Date Utilities
struct DateUtilities {
    
    /// Date format
    struct Formats {
        static let yyyyMMddSlash = "yyyy/MM/dd"
        static let yyyyMMddHHmmSlash = "yyyy/MM/dd HH:mm"
    }
    
    /// Convert ISO date string (e.g. "2018-01-30T08:20:10.000Z") to Date
    ///
    /// - Parameter dateString: date string
    /// - Returns: date object
    static func convertIsoDateStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
        return dateFormatter.date(from: dateString)
    }
    
    /// Format date to string
    ///
    /// - Parameters:
    ///   - date: Date to format
    ///   - format: format string
    /// - Returns: date in formatted string
    static func formatDateToString(date: Date, format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
        
    }
}
