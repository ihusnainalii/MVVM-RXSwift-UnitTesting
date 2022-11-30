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
    static let baseServerURL = "https://gist.githubusercontent.com/hadanischal/ac40457dd1efec40bf9ec43682afae15/raw/1abec65111e7fb885ec20d5b7c9e127a09f8fd79/employee.json"
    static let imageUrl = "https://picsum.photos/1920/1080?random"
}
