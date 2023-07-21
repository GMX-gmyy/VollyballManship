//
//  ClockRecordModel.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/17.
//

import Foundation
import ObjectMapper

class ClockRecordModel: BaseModel {
    
    var date: Int?
    var record: String?

    override func mapping(map: Map) {
        super.mapping(map: map)

        date     <- map["date"]
        record   <- map["record"]
    }
}
