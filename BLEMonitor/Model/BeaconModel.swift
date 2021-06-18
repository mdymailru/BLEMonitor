//
//  BeaconModel.swift
//  BLEMonitor
//
//  Created by mdy on 17.06.2021.
//

import CoreLocation

struct Beacon {
  var name = "mdyBeacon"
  var UUID = "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"
  var major = 1
  var minor = 0
  
}

class BeaconMonitoringModel {
  
  var regions = [Beacon()]
  
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
