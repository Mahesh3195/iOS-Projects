//
//  DetailsTableViewCell.swift
//  NSUrlSessionTableview
//
//  Created by K Mahesh on 11/10/1959 Saka.
//  Copyright © 1959 K Mahesh. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var Title_lbl: UILabel!
    @IBOutlet weak var detail_lbl: UILabel!
    @IBOutlet weak var detail_imv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
