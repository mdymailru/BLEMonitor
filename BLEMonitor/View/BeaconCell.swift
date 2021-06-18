//
//  BeaconCell.swift
//  BLEMonitor
//
//  Created by mdy on 18.06.2021.
//

import UIKit
import CoreLocation

class BeaconCell: UITableViewCell {

  @IBOutlet weak var distanceLabel: UILabel!  
  @IBOutlet weak var rssiLabel: UILabel!
  @IBOutlet weak var majorLabel: UILabel!
  @IBOutlet weak var minorLabel: UILabel!
  @IBOutlet weak var uuidLabel: UILabel!
  
  func setLabel(_ beacon: CLBeacon) {
    uuidLabel.text = beacon.uuid.uuidString
    distanceLabel.text = "\(round(beacon.accuracy * 1000)/1000) m"
    majorLabel.text = "major: \(beacon.major)"
    minorLabel.text = "minor: \(beacon.minor)"
    rssiLabel.text = "\(beacon.rssi)"
  }
  
}
