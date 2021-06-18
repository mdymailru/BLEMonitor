//
//  RegionCell.swift
//  BLEMonitor
//
//  Created by mdy on 18.06.2021.
//

import UIKit

class RegionCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var majorLabel: UILabel!
  @IBOutlet weak var minorLabel: UILabel!
  @IBOutlet weak var uuidLabel: UILabel!
  
  func setLabel(_ region: Beacon) {
    nameLabel.text = region.name
    uuidLabel.text = region.UUID
    majorLabel.text = "major: \(region.major)"
    minorLabel.text = "minor: \(region.minor)"

  }
}
