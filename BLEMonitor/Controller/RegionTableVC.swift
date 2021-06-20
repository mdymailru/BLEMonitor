//
//  RegionTableVC.swift
//  BLEMonitor
//
//  Created by mdy on 17.06.2021.
//

import UIKit

class RegionTableVC: UITableViewController {

  var regions = [Beacon]()
  
  override func viewDidLoad() {
    regions.append(Beacon(name: "Test", UUID: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6", major: 1, minor: 0))
    //regions.append(Beacon(name: "Test2", UUID: "92AB49BE-4127-42F4-B532-90fAF1E26491", major: 0, minor: 0))
    
  }
  
  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView,
          numberOfRowsInSection section: Int) -> Int { return regions.count }
    
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell", for: indexPath) as! RegionCell
    let region = regions[indexPath.row]
    
    cell.setLabel(region)
      
    return cell
    }
  
}
