//
//  RealmEmployee.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainAli. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEmployee: Object {
    @objc dynamic var tenant: String = ""
    @objc dynamic var motd: String = ""
    @objc dynamic var scheduledToday: RealmSchedule?
    let roster = List<RealmRoster>()

    func update(withEmployeeModel employee: EmployeeModel) {
        self.tenant = employee.tenant ?? ""
        self.motd = employee.motd ?? ""
    }
}
