//
//  RealmSchedule.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainAli. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSchedule: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var fromDate: String = ""
    @objc dynamic var toDate: String = ""

    func update(withScheduleModel schedule: ScheduleModel) {
        self.name = schedule.name ?? ""
        self.fromDate = schedule.fromDate ?? ""
        self.toDate = schedule.toDate ?? ""
    }
}
