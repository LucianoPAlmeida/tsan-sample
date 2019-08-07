//
//  DriverTableViewCell.swift
//  TSAN
//
//  Created by Joao Paulo Lopes da Silva on 06/08/19.
//  Copyright © 2019 Almeida Luciano, (Luciano.Almeida@partner.bmw.com.br). All rights reserved.
//

import UIKit

class DriverTableViewCell: UITableViewCell {
	
	static let reuseIdentifier: String = "driverTableViewCell"
	static let nibName: String = "DriverTableViewCell"

	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var number: UILabel!
	@IBOutlet weak var gradientView: UIView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
