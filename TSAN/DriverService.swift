//
//  Service.swift
//  TSAN
//
//  Created by Almeida Luciano, (Luciano.Almeida@partner.bmw.com.br) on 8/6/19.
//  Copyright © 2019 Almeida Luciano, (Luciano.Almeida@partner.bmw.com.br). All rights reserved.
//

import Foundation

class DriverService {
  
  // TODO: Populate
  var list: [Driver] = [
    Driver(name: "Valteri Bottas", number: 77),
    Driver(name: "Lewis Hamilton", number: 44),
    Driver(name: "Sebastian Vettel", number: 5),
    Driver(name: "Charles LeClerc", number: 16),
    Driver(name: "Daniel Riccardo", number: 3)
  ]
  
 // [77, 44, 5, 16, 3]
  var queue = DispatchQueue.global(qos: .userInitiated)
  
  func fetchDriver(number: Int, completion: @escaping (Driver?)-> Void) {
    queue.asyncAfter(deadline: DispatchTime.now() + 1.0) {
      if let driver = self.list.first(where: { $0.number == number }) {
        completion(driver)
      } else {
        completion(nil)
      }
    }
  }
}
