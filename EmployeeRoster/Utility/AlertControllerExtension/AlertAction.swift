//
//  AlertAction.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import UIKit

public struct AlertAction {
    public let title: String
    public let type: Int
    public let style: UIAlertAction.Style

    public init(title: String,
                type: Int = 0,
                style: UIAlertAction.Style = .default) {
        self.title = title
        self.type = type
        self.style = style
    }
}
