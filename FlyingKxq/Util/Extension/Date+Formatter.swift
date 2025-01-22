//
//  Date+Formatter.swift
//  FlyingKxq
//
//  Created by atom on 2025/1/23.
//

import Foundation

extension Date {
    func formatCountdownString(locale: Locale = Locale(identifier: "zh_CN")) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        
        if calendar.isDateInToday(self) {
            dateFormatter.dateFormat = "H:mm"
            return "至" + dateFormatter.string(from: self)
        } else if calendar.isDate(self, equalTo: now, toGranularity: .year) {
            dateFormatter.dateFormat = "M月d日 HH:mm"
            return "至" + dateFormatter.string(from: self)
        } else {
            dateFormatter.dateFormat = "yyyy年M月d日 HH:mm"
            return "至" + dateFormatter.string(from: self)
        }
    }
}
