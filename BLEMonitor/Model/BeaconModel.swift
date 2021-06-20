//
//  BeaconModel.swift
//  BLEMonitor
//
//  Created by mdy on 17.06.2021.
//

import CoreLocation

struct Beacon {
  var name: String
  var UUID: String
  var major: Int
  var minor: Int
  
}

class BeaconMonitoringModel {
  
  func getBeaconRegion(_ beacon: Beacon) -> CLBeaconRegion {
    switch (beacon.major, beacon.minor) {
      case (0, 0):    return CLBeaconRegion(uuid: UUID(uuidString: beacon.UUID)!,
                                      identifier: beacon.UUID)
      case (0...,0):  return CLBeaconRegion(uuid: UUID(uuidString: beacon.UUID)!,
                                           major: CLBeaconMajorValue(beacon.major),
                                      identifier: beacon.UUID)
      default:        return CLBeaconRegion(uuid: UUID(uuidString: beacon.UUID)!,
                                           major: CLBeaconMajorValue(beacon.major),
                                           minor: CLBeaconMinorValue(beacon.minor),
                                      identifier: beacon.UUID)
    }
  }
  
}
