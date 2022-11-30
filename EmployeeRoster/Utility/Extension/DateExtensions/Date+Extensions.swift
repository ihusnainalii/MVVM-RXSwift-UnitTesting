//
//  Date+Extensions.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import Foundation

extension Date {
    var ddMMyyyyString: String {
        return DateFormatter.ddMMyyyy.string(from: self)
    }

    var ddMMyyString: String {
        return DateFormatter.ddMMyy.string(from: self)
    }

    var MMyyyyString: String {
        return DateFormatter.MMyyyy.string(from: self)
    }
}
