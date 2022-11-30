//
//  ScheduleModel.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 28/11/22.
//  Copyright © 2022 HusnainAli. All rights reserved.
//

import Foundation

struct ScheduleModel: Codable, Equatable {
    let name: String?
    let fromDate: String?
    let toDate: String?
}

extension ScheduleModel {
    init?(withRealmSchedule realmSchedule: RealmSchedule?) {
        guard let realmSchedule = realmSchedule else { return nil }
        self.name = realmSchedule.name
        self.fromDate = realmSchedule.fromDate
        self.toDate = realmSchedule.toDate
    }
}
