//
//  Service.swift
//  TSAN
//
//  Created by Almeida Luciano, (Luciano.Almeida@partner.bmw.com.br) on 8/6/19.
//  Copyright © 2019 Almeida Luciano, (Luciano.Almeida@partner.bmw.com.br). All rights reserved.
//

import Foundation

class DriverService {
	
  var list: [Driver] = [
    Driver(name: "Lewis Hamilton", number: 44, position: 1, teamColor: "#00D2BE"),
    Driver(name: "Sebastian Vettel", number: 5, position: 2, teamColor: "#DC0000"),
	Driver(name: "Valteri Bottas", number: 77, position: 3, teamColor: "#00D2BE"),
    Driver(name: "Charles LeClerc", number: 16, position: 4, teamColor: "#DC0000"),
	Driver(name: "Daniel Riccardio", number: 3, position: 5, teamColor: "#FFF500"),
	Driver(name: "Lando Norris", number: 4, position: 6, teamColor: "#FF8700")
  ]
	
  var queue = DispatchQueue.global(qos: .userInitiated)
  
  func fetchDriver(position: Int, completion: @escaping (Driver?)-> Void) {
    queue.asyncAfter(deadline: DispatchTime.now() + 1.0) {
      if let driver = self.list.first(where: { $0.position == position }) {
        completion(driver)
      } else {
        completion(nil)
      }
    }
  }
}
