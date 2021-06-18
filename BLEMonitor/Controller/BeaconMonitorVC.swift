//
//  BeaconMonitorVC.swift
//  BLEMonitor
//
//  Created by mdy on 17.06.2021.
//

import UIKit
import CoreLocation


class BeaconVC: UIViewController {

  @IBOutlet var regionsContainer: UIView!
  
  var regionTableVC: RegionTableVC!
  var beaconTableVC: BeaconTableVC!
  
  var model = BeaconMonitoringModel()
  
  let locationManager = CLLocationManager()
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let regionsTableVC = segue.destination as? RegionTableVC {
      self.regionTableVC = regionsTableVC
    }
    if let beaconsTableVC = segue.destination as? BeaconTableVC {
      self.beaconTableVC = beaconsTableVC
    }
  
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    regionTableVC.regions = model.regions
   
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    
  }

  override func viewWillAppear(_ animated: Bool) {
    startMonitoring()
  }
  override func viewDidDisappear(_ animated: Bool) {
    for region in locationManager.monitoredRegions {
      guard let regionBeacon = region as? CLBeaconRegion else { continue }
      print("stop monitoring: \(regionBeacon.uuid)")
      locationManager.stopMonitoring(for: region)
      locationManager.stopRangingBeacons(satisfying: regionBeacon.beaconIdentityConstraint)
    }
    
  }

}
 
//MARK: CLLocationManagerDelegate
extension BeaconVC: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager,
         didDetermineState state: CLRegionState,
                      for region: CLRegion) {
    
    guard let regionBeacon = region as? CLBeaconRegion else { return }
    switch state {
      case .inside:
        print("in region: \(regionBeacon.uuid)")
        manager.startRangingBeacons(satisfying: regionBeacon.beaconIdentityConstraint)
      case .outside:
        print("out region: \(regionBeacon.uuid)")
        manager.stopRangingBeacons(satisfying: regionBeacon.beaconIdentityConstraint)
      default:
        print("no state")
    }
  }
  
  func locationManager(_ manager: CLLocationManager,
                didRange beacons: [CLBeacon],
     satisfying beaconConstraint: CLBeaconIdentityConstraint) {
    
    beaconTableVC.beacons[beaconConstraint] = beacons.sorted(by: {$1.accuracy > $0.accuracy })
    beaconTableVC.tableView.reloadData()
     
    beacons.forEach
      { print("\($0.proximity.rawValue) \($0.rssi) \($0.uuid) \($0.major) \($0.minor) \($0.accuracy)") }
  }
    
  func startMonitoring() {
    for beacon in model.regions {
      let beconRegion = model.getBeaconRegion(beacon)
      locationManager.startMonitoring(for: beconRegion)
      print("start monitoring: \(beconRegion.uuid) \(beconRegion.major ?? -1) \(beconRegion.minor ?? -1)")
    }
  }
  
}
