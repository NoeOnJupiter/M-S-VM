//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI

public extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    func string(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    func isSame(_ intervals: [DateInterval], as date: Date) -> Bool {
        return !intervals.map({self.isSame($0, as: date)}).contains(false)
    }
    func isSame(_ interval: DateInterval, as date: Date) -> Bool {
        switch interval {
            case .day:
                return Calendar.current.isDate(date, inSameDayAs: self)
            case .week:
                let week = Calendar.current.component(.weekOfYear, from: self)
                let comparedWeek = Calendar.current.component(.weekOfYear, from: self)
                return week == comparedWeek
            case .month:
                let month = Calendar.current.component(.month, from: self)
                let comparedMonth = Calendar.current.component(.month, from: self)
                return month == comparedMonth
            case .year:
                let year = Calendar.current.component(.year, from: self)
                let comparedYear = Calendar.current.component(.year, from: self)
                return year == comparedYear
        }
    }
}
