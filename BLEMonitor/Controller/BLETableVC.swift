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

   


