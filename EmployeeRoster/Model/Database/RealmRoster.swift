//
//  RealmRoster.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainAli. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRoster: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var fromDate: String = ""
    @objc dynamic var toDate: String = ""

    func update(withRosterModel roster: RosterModel) {
        self.name = roster.name ?? ""
        self.fromDate = roster.fromDate ?? ""
        self.toDate = roster.toDate ?? ""
    }
}
