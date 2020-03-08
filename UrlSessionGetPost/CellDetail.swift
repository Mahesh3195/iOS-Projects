//
//  CellDetail.swift
//  UrlSessionGetPost
//
//  Created by K Mahesh on 18/12/1941 Saka.
//  Copyright © 1941 K Mahesh. All rights reserved.
//

import UIKit

class CellDetail: UIViewController {

    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var person_imv: UIImageView!
    var name = ""
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name_lbl.text = "Your selected image is \(name)"
        person_imv.image = image
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
