//
//  MockError.swift
//  EmployeeRosterTests
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import Foundation

enum MockError: Error, Equatable {
    case unknown
}

let mockError = MockError.unknown
