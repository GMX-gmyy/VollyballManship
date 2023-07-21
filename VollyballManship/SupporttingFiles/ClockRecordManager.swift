//
//  ClockRecordManager.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/17.
//

import Foundation
import UIKit

let kClockRecord = "kClockRecord"
let kRecordDays = "RecordDays"
class ClockRecordManager: NSObject {
    static let shared = ClockRecordManager()
    
    func getRecordInfo() -> [ClockRecordModel] {
        let string = (UserDefaults.standard.value(forKey: kClockRecord) as? String) ?? ""
        if string.count == 0 {
            return []
        }
        let model = Array<ClockRecordModel>(JSONString: string) ?? []
        return model
    }

    func saveRecordInfo(model: ClockRecordModel) {
        var models = getRecordInfo()
        models.append(model)
        UserDefaults.standard.set(models.toJSONString(), forKey: kClockRecord)
        UserDefaults.standard.synchronize()
    }
    
    func getRecordDays() -> [Int] {
        let array = UserDefaults.standard.array(forKey: kRecordDays) ?? []
        return (array as? [Int]) ?? []
    }
    
    func saveRecordDays(date: Date) {
        let records = getRecordInfo()
        let lastDate = DateToolsMannager.dateFromTimestamp(timeStamp: records.last?.date ?? 0)
        let days = Calendar.current.dateComponents([.day], from: lastDate, to: date).day
        if (days == 0) {
            return
        }
        if (days == 1) {
            var daysRecords = getRecordDays()
            var lastDays = daysRecords.last ?? 0
            lastDays += 1
            if (daysRecords.count > 0) {
                daysRecords.removeLast()
            }
            daysRecords.append(lastDays)
            UserDefaults.standard.setValue(daysRecords, forKey: kRecordDays)
            UserDefaults.standard.synchronize()
        } else {
            var daysRecords = getRecordDays()
            let new = 1
            daysRecords.append(new)
            UserDefaults.standard.setValue(daysRecords, forKey: kRecordDays)
            UserDefaults.standard.synchronize()
        }
    }
    
    func hasSignedWeek() -> Bool {
        let days = getRecordDays()
        var result = false
        for day in days {
            if day >= 7 {
                result = true
                break
            }
        }
        return result
    }
    
    func hasSignedMonth() -> Bool {
        let days = getRecordDays()
        var result = false
        for day in days {
            if day >= 30 {
                result = true
                break
            }
        }
        return result
    }
    
    func hasSignedYear() -> Bool {
        let days = getRecordDays()
        var result = false
        for day in days {
            if day >= 365 {
                result = true
                break
            }
        }
        return result
    }
}
