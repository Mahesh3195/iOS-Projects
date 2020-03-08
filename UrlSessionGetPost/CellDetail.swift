//
//  CellDetail.swift
//  UrlSessionGetPost
//
//  Created by K Mahesh on 17/12/1941 Saka.
//  Copyright © 1941 K Mahesh. All rights reserved.
//

import UIKit

class CellDetail: UIViewController {

    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var person_imv: UIImageView!
    var image = UIImage()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name_lbl.text = "Your Selected image is \(name)."
        person_imv.image = image
        
    }
    
}
