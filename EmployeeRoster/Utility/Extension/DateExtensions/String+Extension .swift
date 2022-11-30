//
//  String+Extension .swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import Foundation

extension String {
    var yyyyMMddDate: Date? {
        return DateFormatter.yyyyMMdd.date(from: self)
    }
}
