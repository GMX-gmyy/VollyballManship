//
//  DateToolsMannager.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/18.
//

import Foundation
import SwiftDate

enum TimeFormat: String {
    case YYYYMMDD = "YYYY-MM-dd"
    case YYYYMMDDHHMM = "YYYY-MM-dd HH:mm"
    case YYYYMMDDHHMMSS = "YYYY-MM-dd HH:mm:ss"
    case YYYYMMDDHHMMSSsss = "YYYY-MM-dd HH:mm:ss.SSS"
}

class DateToolsMannager: NSObject {

    //获取当前时间是星期几
    public static func getWeekday(_ date: Date = Date()) -> String {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second], from: date)
        let weekDay = comps.weekday! - 1
        let array = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        return array[weekDay]
    }

    public static func getWeeksDate() -> [Date]? {
        //当前时间
        let currentDate = Date()
        let calender = Calendar.current
        var comp = calender.dateComponents([.year, .month, .day, .weekday], from: currentDate)
        //当前时间是几号、周几
        let currentDay = comp.day
        let weeKDay = comp.weekday
        //如果获取当前时间的日期和周几失败，返回nil
        guard let day = currentDay, let week = weeKDay else {
            return nil
        }
        //由于1代表的是周日，因此计算出准确的周几
        var currentWeekDay = 0
        if week == 1 {
            currentWeekDay = 7
        } else {
            currentWeekDay = week - 1
        }
        //1 ... 7表示周一到周日
        //进行遍历和currentWeekDay进行比较，计算出之间的差值，即为当前日期和一周时间日期的差值，即可计算出一周时间内准备的日期
        var dates: [Date] = []
        for index in 1 ... 7 {
            let diff = index - currentWeekDay
            comp.day = day + diff
            let date = calender.date(from: comp)
            //由于上述方法返回的Date为可选类型，要进行判空处理
            if let _ = date {
                dates.append(date!)
            }
        }
        //返回时间数组
        return dates
    }

/// 将时间戳转为时间
    /// - Parameters:
    ///   - timeFormat: 时间类型
    ///   - timeString: 时间戳
    public static func getTimeFromTimestamp(timeFormat:String, timeString:Int) -> String {
        let newTime = timeString
        let myDate = Date(timeIntervalSince1970: TimeInterval(newTime))
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
        let timeString = formatter.string(from: myDate)
        return timeString
    }

    /// 获取当前时间戳
    /// - Parameters:
    ///   - timeFormat: 时间类型
    public static func getNowTimeTimestamp(timeFormat: String, _ date: Date = Date()) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
//        let timezone = TimeZone(identifier: "Asia/Beijing")
//        formatter.timeZone = timezone
        let timeSp = date.timeIntervalSince1970
        return Int(timeSp)
    }

    public static func dateFromTimestamp(timeStamp: Int) -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        return date
    }

    /// 获取当前时间
    /// - Parameter timeFormat: 时间类型，TimeFormat为枚举
    public static func getCurrentTime(timeFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
//        let timezone = TimeZone(identifier: "Asia/Beijing")
//        formatter.timeZone = timezone
        let dateTime = formatter.string(from: Date())
        return dateTime
    }

    /// 字符串时间转时间戳
    /// - Parameters:
    ///   - timeFormat: 时间格式
    ///   - timeString: 要转的字符串时间
    public static func timeToTimestamp(timeFormat:String,timeString:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
//        let timezone = TimeZone(identifier: "Asia/Beijing")
//        formatter.timeZone = timezone
        let dateTime = formatter.date(from: timeString)
        return String(dateTime!.timeIntervalSince1970)
    }
}
