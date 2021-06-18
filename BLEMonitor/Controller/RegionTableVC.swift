//
//  RegionTableVC.swift
//  BLEMonitor
//
//  Created by mdy on 17.06.2021.
//

import UIKit

class RegionTableVC: UITableViewController {

  var regions: [Beacon]!
  

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
