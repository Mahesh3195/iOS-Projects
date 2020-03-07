//
//  change_pwd_page.swift
//  Fish_Buddy
//
//  Created by o3sa on 26/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import UnderLineTextField

@available(iOS 12.0, *)
class change_pwd_page: UIViewController,UITextFieldDelegate {
    
    var main_view: UIView!
    var txt:UnderLineTextField!
    var txt_apnd_arr = [UITextField]()
    var submit_btn: UIButton!
    var ph_arr = ["Old Password","New Password","Confirm Password"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    
    func initialization(){
        
        Stored.width = self.view.frame.size.width
        Stored.height = self.view.frame.size.height
        
        //NAVIGATION
        navv.intilization(self_: self)
        navv.nav_main_view = self.view;
        
        navv.Nav_View_with_back_btn(_title: "Change Password", back_page: "log_catch_pg", back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
        
        //MAIN VIEW
        main_view = Views.Main_view_without_btm_bar(_subViewIn: self.view, _y: ui.add_y_pos(o: navv.back_view, s: 0))
        //main_view.backgroundColor = UIColor.yellow
        
        design_initialization()
        
    }
    
    func design_initialization(){
        
        let logo_imv = Imagevws.bg_imv(_x: 0, _y: 50, _w: 100, _h: 100, _imgName: "signin-logo.png", _sbvw: main_view)
        logo_imv.center.x = main_view.frame.size.width/2
        
        if(Stored.Device == "iPad"){
            logo_imv.frame.size.width = 180
            logo_imv.frame.size.height = 180
        }
        
        for i in 0..<ph_arr.count{
            
            txt = Textfields.underline_txt_fld(x: 15, y: 0, w: ui.get_w(o: main_view)-30, h: 60, ph_hldr: ph_arr[i], tag: i, sbv: main_view)
            txt.delegate = self
            txt.isSecureTextEntry = true
            txt_apnd_arr.append(txt)
            
            Stored.y_pos = CGFloat(i) * CGFloat(txt.frame.size.height)
            txt.frame.origin.y = Stored.y_pos + ui.add_y_pos(o: logo_imv, s: 30)
            
        }
        
        submit_btn = Buttons.long_btn(x: 15, y: ui.add_y_pos(o: txt, s: 25), w: ui.get_w(o: main_view)-30, _title: "Submit", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: main_view)
        submit_btn.addTarget(self, action: #selector(submit_btn_clicked(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func submit_btn_clicked(_ sender: UIButton){
        
        print("Submit button clicked")
        /*if(txt_apnd_arr[0].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter Old Password")
        }else if(txt_apnd_arr[1].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter New Password")
        }else if(txt_apnd_arr[2].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter Confirm Password")
        }else if(txt_apnd_arr[1].text! != txt_apnd_arr[2].text!){
            Stored.alert_method(_title: "", _Content: "Password does not matches")
        }else{
            navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        }*/
        
        navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
    }
    
    
    var statusBarHidden = false
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
