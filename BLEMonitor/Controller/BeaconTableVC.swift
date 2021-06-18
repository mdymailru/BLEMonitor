//
//  BeaconTableVC.swift
//  BLEMonitor
//
//  Created by mdy on 17.06.2021.
//

import UIKit
import CoreLocation

class BeaconTableVC: UITableViewController {

  var beacons = [CLBeaconIdentityConstraint: [CLBeacon]]()
  weak var detailVC: DetailBeaconDelegate? //DetailBeaconVC?
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let detailVC = segue.destination as? DetailBeaconVC
    self.detailVC = detailVC
  }
  
  // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      return beacons.count
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Array(beacons.values)[section].count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconCell", for: indexPath) as! BeaconCell

    let sectionkey = Array(beacons.keys)[indexPath.section]
    let beacon = beacons[sectionkey]![indexPath.row]
      
    cell.setLabel(beacon)
    detailVC?.updateLabel(section: indexPath.section, row: indexPath.row, beacon: beacon)
    return cell
  }
 
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    detailVC?.index = (indexPath.section, indexPath.row)
  }
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let sectionItem = beacons.keys.map({$0})[section]
    return "\(sectionItem.uuid) (\(sectionItem.major ?? 0),\(sectionItem.minor ?? 0))"
  }
    
  override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
      let header = view as! UITableViewHeaderFooterView
      if let textlabel = header.textLabel {
          textlabel.font = textlabel.font.withSize(13)
      }
  }
    

}
