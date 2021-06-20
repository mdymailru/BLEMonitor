//
//  DetailVCDelegatePr.swift
//  BLEMonitor
//
//  Created by mdy on 20.06.2021.
//

import CoreLocation

protocol DetailBeaconDelegate: AnyObject {
  var index: (section: Int, row: Int)? {get set}
  func updateLabel(section: Int, row: Int, beacon: CLBeacon)
}
