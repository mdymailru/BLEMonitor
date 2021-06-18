//
//  DetailBeaconVC.swift
//  BLEMonitor
//
//  Created by mdy on 18.06.2021.
//

import UIKit
import CoreLocation

class DetailBeaconVC: UIViewController {

  @IBOutlet weak var uuidLabel: UILabel!
  @IBOutlet weak var majorLabel: UILabel!
  @IBOutlet weak var minorLabel: UILabel!
  @IBOutlet weak var rssiLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  
  var index: (section: Int, row: Int)?
  
  @IBAction func closeTouch() {
    dismiss(animated: true, completion: nil)
  }
}


extension DetailBeaconVC {
  
  func updateLabel(section: Int, row: Int, beacon: CLBeacon) {
    guard self.index?.row == row && self.index?.section == section else { return }
    uuidLabel.text = beacon.uuid.uuidString
    distanceLabel.text = "Distance, m: \(round(beacon.accuracy * 1000)/1000)"
    majorLabel.text = "Major: \(beacon.major)"
    minorLabel.text = "Minor: \(beacon.minor)"
    rssiLabel.text = "RSSI: \(beacon.rssi)"
  }
}
