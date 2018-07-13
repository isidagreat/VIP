//
//  CustomStandingTableViewCell.swift
//  VIP
//
//  Created by Isidro Arzate on 7/12/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import UIKit

class CustomStandingTableViewCell: UITableViewCell {

    @IBOutlet weak var lossesLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    var teamDict: NSDictionary?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
