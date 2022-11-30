//
//  RosterModel.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 28/11/22.
//  Copyright © 2022 HusnainAli. All rights reserved.
//

import Foundation

struct RosterModel: Codable, Equatable {
    let name: String?
    let fromDate: String?
    let toDate: String?
}

extension RosterModel {
    init(withRealmRoster realmRoster: RealmRoster) {
        self.name = realmRoster.name
        self.fromDate = realmRoster.fromDate
        self.toDate = realmRoster.toDate
    }
}
