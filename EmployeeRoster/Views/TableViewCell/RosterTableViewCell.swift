//
//  RosterTableViewCell.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import UIKit

class RosterTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel?.textColor = UIColor.white
        startDateLabel?.textColor = UIColor.white
        endDateLabel?.textColor = UIColor.white

        nameLabel?.font = .heading1
        startDateLabel?.font = .body1
        endDateLabel?.font = .body2
        photoImageView?.contentMode = UIView.ContentMode.scaleAspectFill
    }

    func configure(_ data: EmployeeListDTO) {
        nameLabel?.text = data.name
        startDateLabel?.text = "Start Date: \(data.fromDate)"
        endDateLabel?.text = "End date:\(data.toDate)"
        photoImageView?.setImage(url: URL.imageUrl)
    }
}
