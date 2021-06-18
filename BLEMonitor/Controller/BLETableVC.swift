//
//  BLETableVC.swift
//  BLEMonitor
//
//  Created by mdy on 17.06.2021.
//

import UIKit
import CoreBluetooth

class BLETableVC: UITableViewController {

  var centralManager: CBCentralManager!
  var BLEItemDic = [UUID: BLEDevices]()
  var BLEItem = [BLEDevices]()
  var timer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    startScanBLE()
    timer = Timer.scheduledTimer(timeInterval: 35, target: self,
                                                 selector: #selector(reloadScan),
                                                 userInfo: nil, repeats: true)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    centralManager.stopScan()
    BLEItemDic.removeAll()
    timer?.invalidate()
    print("stop scan BLE")
  }

  // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
          numberOfRowsInSection section: Int) -> Int { return BLEItem.count }
  
    override func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "BLECell",
                                                          for: indexPath) as! BLECell
      cell.nameBLELabel.text = BLEItem[indexPath.row].name
      cell.idLabel.text = "\(BLEItem[indexPath.row].uuid)"
      cell.rssiLabel.text = "\(BLEItem[indexPath.row].rssi)"
      
      return cell
    }
    
}

//MARK: CBCentralManagerDelegate
extension BLETableVC: CBCentralManagerDelegate {
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
      case CBManagerState.poweredOn :
        startScanBLE()
      default:
        print("no bluetooth")
    }
  }
    
  func centralManager(_ central: CBCentralManager,
         didDiscover peripheral: CBPeripheral,
              advertisementData: [String : Any],
                      rssi RSSI: NSNumber) {
    
    let id = peripheral.identifier
    BLEItemDic[id] = BLEDevices(uuid: "\(id)",
                                name: peripheral.name ?? "NoName",
                                rssi: RSSI.intValue)
    
    BLEItem = BLEItemDic.map{ $1 }.sorted{ $0.rssi > $1.rssi }
    tableView.reloadData()
  }
  
  func startScanBLE() {
    guard centralManager.state == .poweredOn else { return }
    BLEItemDic.removeAll()
    centralManager.scanForPeripherals(withServices: nil, options: nil)
  }
  
  @objc func reloadScan() {
    BLEItemDic.removeAll()
    centralManager.stopScan()
    startScanBLE()
  }

}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


