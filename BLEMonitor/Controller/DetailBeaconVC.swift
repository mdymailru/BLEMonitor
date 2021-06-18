//
//  DetailBeaconVC.swift
//  BLEMonitor
//
//  Created by mdy on 18.06.2021.
//

import UIKit
import CoreLocation

protocol DetailBeaconDelegate: AnyObject {
  var index: (section: Int, row: Int)? {get set}
  func updateLabel(section: Int, row: Int, beacon: CLBeacon)
}

class DetailBeaconVC: UIViewController {

  @IBOutlet private weak var uuidLabel: UILabel!
  @IBOutlet private weak var majorLabel: UILabel!
  @IBOutlet private weak var minorLabel: UILabel!
  @IBOutlet private weak var rssiLabel: UILabel!
  @IBOutlet private weak var distanceLabel: UILabel!
  
  var index: (section: Int, row: Int)?
  
  @IBAction private func closeTouch() {
    dismiss(animated: true, completion: nil)
  }
}


extension DetailBeaconVC: DetailBeaconDelegate {
  
  func updateLabel(section: Int, row: Int, beacon: CLBeacon) {
    guard self.index?.row == row && self.index?.section == section else { return }
    uuidLabel.text = beacon.uuid.uuidString
    distanceLabel.text = "Distance, m: \(round(beacon.accuracy * 1000)/1000)"
    majorLabel.text = "Major: \(beacon.major)"
    minorLabel.text = "Minor: \(beacon.minor)"
    rssiLabel.text = "RSSI: \(beacon.rssi)"
  }
}
