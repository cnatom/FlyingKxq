//
//  FlyDateFormatter.swift
//  FlyingKxq
//
//  Created by atom on 2025/2/6.
//
import Foundation

class FlyDateFormatter {
    static func newsParse(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = formatter.date(from: dateString) else {
            return ""
        }
        let calendar = Calendar.current
        let now = Date()
        
        // 配置日期格式
        let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter
        }()
        
        let monthDayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "M月d日"
            return formatter
        }()
        
        let fullFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter
        }()
        
        // 判断时间范围
        if calendar.isDateInToday(date) {
            return timeFormatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            return "昨天 \(timeFormatter.string(from: date))"
        } else if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
            return monthDayFormatter.string(from: date)
        } else {
            return fullFormatter.string(from: date)
        }
    }
}
