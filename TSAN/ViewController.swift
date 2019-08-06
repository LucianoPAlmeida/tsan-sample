//
//  ViewController.swift
//  TSAN
//
//  Created by Almeida Luciano, (Luciano.Almeida@partner.bmw.com.br) on 8/6/19.
//  Copyright © 2019 Almeida Luciano, (Luciano.Almeida@partner.bmw.com.br). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var data: [Driver] = []
  
  var ids: [Int] = [77, 44, 5, 16, 3]
  
  var service: DriverService = DriverService()
  
  var lock = NSLock()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    fetchDrivers()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func fetchDrivers() {
    let group = DispatchGroup()
    
    for id in self.ids {
        group.enter()
        self.service.fetchDriver(number: id, completion: { (driver) in
//          self.lock.lock()
          if let driver = driver {
            self.data.append(driver)
          }
//          self.lock.unlock()
          group.leave()
        })
    }
    
    group.notify(queue: .main) {
      self.tableView.reloadData()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    let driver = data[indexPath.row]
    cell.textLabel?.text = driver.name
    cell.detailTextLabel?.text = "#\(driver.number)"
    
    return cell
  }
}
