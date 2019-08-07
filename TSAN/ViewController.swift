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
	var numberPositions: Int = 6
	var service: DriverService = DriverService()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		registerNibs()
		fetchDrivers()
	}
	
	func registerNibs() {
		tableView.register(UINib(nibName: DriverTableViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: DriverTableViewCell.reuseIdentifier)
	}
  
	func fetchDrivers() {
		let group = DispatchGroup()
		
		for position in 1...numberPositions {
			group.enter()
			self.service.fetchDriver(position: position, completion: { (driver) in
				if let driver = driver {
					self.data.append(driver)
				}
				group.leave()
			})
		}
		
		group.notify(queue: .main) {
			self.tableView.reloadData()
		}
	}
	
	func hexStringToUIColor (hex:String) -> UIColor {
		var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		
		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}
		
		if ((cString.count) != 6) {
			return UIColor.gray
		}
		
		var rgbValue:UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)
		
		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
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
		return generateDriverCell(tableView: tableView, indexPath: indexPath)
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120
	}
	
	private func generateDriverCell(tableView: UITableView, indexPath: IndexPath) -> DriverTableViewCell {
		guard let cell: DriverTableViewCell = tableView.dequeueReusableCell(withIdentifier: DriverTableViewCell.reuseIdentifier, for: indexPath) as? DriverTableViewCell else {
			return DriverTableViewCell()
		}
		
		let driver = data[indexPath.row]
		cell.name.text = "\(driver.name)"
		cell.number.text = "#\(driver.number)"
		cell.backgroundColor = hexStringToUIColor(hex: driver.teamColor)
		cell.gradientView.backgroundColor = hexStringToUIColor(hex: driver.teamColor)
		
		let gradientLayer:CAGradientLayer = CAGradientLayer()
		gradientLayer.frame.size = cell.frame.size
		gradientLayer.colors =
			[UIColor.black.withAlphaComponent(0.5).cgColor,hexStringToUIColor(hex: driver.teamColor).withAlphaComponent(1).cgColor]
		cell.gradientView.layer.addSublayer(gradientLayer)
		gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
		gradientLayer.endPoint = CGPoint(x: 0.7, y: 1.0)
	
		return cell
	}
}
