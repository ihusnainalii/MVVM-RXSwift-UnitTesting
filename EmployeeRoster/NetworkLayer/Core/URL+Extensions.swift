//
//  URL+Extensions.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 Husnain Ali. All rights reserved.
//

import Foundation

extension URL {
    static var sourcesUrl: URL { URL(string: ApiConstant.baseServerURL)! }
    static var imageUrl: URL { URL(string: ApiConstant.imageUrl)! }
}

struct ApiConstant {
    static let baseServerURL = "https://raw.githubusercontent.com/ihusnainalii/MVVM-RXSwift-UnitTesting/main/employees.json"
    static let imageUrl = "https://picsum.photos/1920/1080?random"
}
