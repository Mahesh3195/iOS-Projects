//
//  sign_in_page.swift
//  Fish_Buddy
//
//  Created by o3sa on 20/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import UnderLineTextField

@available(iOS 12.0, *)
class sign_in_page: UIViewController,UITextFieldDelegate {

    var main_view: UIView!
    var scrl_vw: UIScrollView!
    var btns_vw: UIView!
    var sign_in_vw: UIView!
    var sign_up_vw: UIView!
    var sign_in_btn: UIButton!
    var sign_up_btn: UIButton!
    var signin_submit_btn:UIButton!
    var signup_submit_btn:UIButton!
    var signin_txt:UnderLineTextField!
    var signup_txt:UnderLineTextField!
    var forgot_pswd_btn:UIButton!
    var fb_btn: UIButton!
    var google_btn: UIButton!
    var signin_apnd_txt = [UITextField]()
    var signup_apnd_txt = [UITextField]()
    var signin_ph_arr = ["Email","Password"]
    
    var signup_ph_arr = ["Name","Phone","Email","Password","Confirm Password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }
    
    func initialization(){
        
        Stored.width = self.view.frame.size.width
        Stored.height = self.view.frame.size.height
        
        //NAVIGATION
        navv.intilization(self_: self)
        
        //MAIN VIEW
        main_view = Views.start_main_view(_subViewIn: self.view)
        //main_view.backgroundColor = UIColor.yellow
        
        design_initialization()
        
    }
    
    func design_initialization(){
        
        scrl_vw = Views.scrl_View_v(_y: 0, _h: ui.get_h(o: main_view), _ch: 700, _subv: main_view)
        
        let logo_imv = Imagevws.bg_imv(_x: 0, _y: 30, _w: 100, _h: 100, _imgName: "signin-logo.png", _sbvw: scrl_vw)
        logo_imv.center.x = main_view.frame.size.width/2
        
        if(Stored.Device == "iPad"){
            logo_imv.frame.size.width = 180
            logo_imv.frame.size.height = 180
        }
        
        btns_vw = Views.cust_view(_x: 0, y: ui.add_y_pos(o: logo_imv, s: 40), w: ui.get_w(o: scrl_vw), _h: 35, bgcolor: UIColor.clear, _sbv: scrl_vw)
        
        /********************************* SIGN IN ***************************************/
        
        sign_in_btn = Buttons.small_btn(x: (ui.get_w(o: scrl_vw)/2 - ui.get_w(o: scrl_vw)/4) - 15, y: 0, _title: "SIGN IN", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: btns_vw)
        sign_in_btn.addTarget(self, action: #selector(sign_in_btn_clicked(_:)), for: .touchUpInside)
       
        sign_in_vw = Views.cust_view(_x: 0, y: ui.add_y_pos(o: btns_vw, s: 0), w: ui.get_w(o: scrl_vw), _h: ui.get_h(o: scrl_vw) - ui.get_h(o: btns_vw) - 150, bgcolor: UIColor.clear, _sbv: scrl_vw)
        sign_in_vw.isHidden = false
        
        for i in 0..<signin_ph_arr.count{
            
            signin_txt = Textfields.underline_txt_fld(x: 15, y: 0, w: ui.get_w(o: sign_in_vw)-30, h: 60, ph_hldr: signin_ph_arr[i], tag: i, sbv: sign_in_vw)
            signin_txt.delegate = self
            signin_apnd_txt.append(signin_txt)
            
            Stored.y_pos = CGFloat(i) * CGFloat(signin_txt.frame.size.height)
            signin_txt.frame.origin.y = Stored.y_pos + 20
            
            if(i == 1){
                signin_txt.isSecureTextEntry = true
            }
            
        }
        
        signin_submit_btn = Buttons.long_btn(x: 15, y: ui.add_y_pos(o: signin_txt, s: 25), w: ui.get_w(o: sign_in_vw)-30, _title: "SIGN IN", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: sign_in_vw)
        signin_submit_btn.addTarget(self, action: #selector(signin_submit_clicked(_:)), for: .touchUpInside)
        
        forgot_pswd_btn = Buttons.only_title_btn(x: 0, y: ui.add_y_pos(o: signin_submit_btn, s: 25), w: ui.get_w(o: sign_in_vw), title_txt: "Forgot Password ?", title_clr: Colors.orange, btn_algnmt: .center, sbv: sign_in_vw)
        forgot_pswd_btn.addTarget(self, action: #selector(forgot_password_clicked(_:)), for: .touchUpInside)
        
        let or_vw = Views.or_view(y: ui.add_y_pos(o: forgot_pswd_btn, s: 20), _sbv: sign_in_vw)

        fb_btn = Buttons.btn_with_img(x: 15, y: ui.add_y_pos(o: or_vw, s: 20), w: ui.get_w(o: sign_in_vw)-30, title_txt: "Sign in with Facebook", img_name: "facebook.png", title_clr: Colors.white, msk_clr: Colors.Clear_color(), bgClr: Colors.fb_clr, sbv: sign_in_vw)
        fb_btn.addTarget(self, action: #selector(fb_btn_clicked(_:)), for: .touchUpInside)

        google_btn = Buttons.btn_with_img(x: 15, y: ui.add_y_pos(o: fb_btn, s: 20), w: ui.get_w(o: sign_in_vw)-30, title_txt: "Sign in with Google", img_name: "google-plu.png", title_clr: Colors.white, msk_clr: Colors.white, bgClr: Colors.google_clr, sbv: sign_in_vw)
        google_btn.addTarget(self, action: #selector(googlebtn_clicked(_:)), for: .touchUpInside)
        
       
        /********************************* SIGN UP ***************************************/
        
        sign_up_btn = Buttons.small_btn(x: ui.add_x_pos(o: sign_in_btn, s: 25), y: 0, _title: "SIGN UP", title_Clr: Colors.light_grey_clr, bg_clr: Colors.Clear_color(), sbv: btns_vw)
        sign_up_btn.addTarget(self, action: #selector(sign_up_btn_clicked(_:)), for: .touchUpInside)
        
        sign_up_vw = Views.cust_view(_x: 0, y: ui.add_y_pos(o: btns_vw, s: 0), w: ui.get_w(o: scrl_vw), _h: ui.get_h(o: scrl_vw) - ui.get_h(o: btns_vw) - 150, bgcolor: Colors.Clear_color(), _sbv: scrl_vw)
        sign_up_vw.isHidden = true
        
        for j in 0..<signup_ph_arr.count {
            
            signup_txt = Textfields.underline_txt_fld(x: 15, y: 0, w: ui.get_w(o: sign_up_vw) - 30, h: 60, ph_hldr: signup_ph_arr[j], tag: j, sbv: sign_up_vw)
            signup_txt.delegate = self
            signup_apnd_txt.append(signup_txt)
            
            Stored.y_pos = CGFloat(j) * CGFloat(signup_txt.frame.size.height)
            signup_txt.frame.origin.y = Stored.y_pos + 20
            
            if(j == 1){
                signup_txt.keyboardType = .numberPad
            }
            if(j == 2){
                signup_txt.keyboardType = .emailAddress
            }
            if(j == 3 || j == 4){
                signup_txt.isSecureTextEntry = true
            }
            
        }
        
        signup_submit_btn = Buttons.long_btn(x: 15, y: ui.add_y_pos(o: signup_txt, s: 25), w: ui.get_w(o: sign_up_vw)-30, _title: "SIGN UP", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: sign_up_vw)
        signup_submit_btn.addTarget(self, action: #selector(signup_submit_clicked(_:)), for: .touchUpInside)
        
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        if(textField.tag == 2){
            self.view.frame.origin.y = -50
        }
        
        if(textField.tag == 3){
            self.view.frame.origin.y = -60
        }
        
        if(textField.tag == 4){
            self.view.frame.origin.y = -130
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for j in 0..<signup_apnd_txt.count{
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func signin_submit_clicked(_ sender:UIButton){
        
        print("signin submit button clicked")
        /*if(signin_apnd_txt[0].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter Email")
        }else if(signin_apnd_txt[1].text?.isEmpty)!{
             Stored.alert_method(_title: "", _Content: "Please enter Password")
        }else{
            navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        }*/
        navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
    }
    
    @objc func signup_submit_clicked(_ sender:UIButton){
        
        print("signup submit button clicked")
       /* if(signup_apnd_txt[0].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter Name")
        }else if(signup_apnd_txt[1].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter Phone Number")
        }else if (signup_apnd_txt[1].text?.count)! <= 9 {
            Stored.alert_method(_title: "", _Content: "Please enter valid Phone Number")
        }else if (signup_apnd_txt[1].text?.count)! >= 12 {
            Stored.alert_method(_title: "", _Content: "Please enter valid Phone Number")
        }else if(signup_apnd_txt[2].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter Email")
        }else if(signup_apnd_txt[3].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter Password")
        }else if(signup_apnd_txt[4].text?.isEmpty)!{
            Stored.alert_method(_title: "", _Content: "Please enter Confirm Password")
        }else if(signup_apnd_txt[3].text! != signup_apnd_txt[4].text!){
            Stored.alert_method(_title: "", _Content: "Password and Confirm Password doesnot matches")
        }else{
            sign_in_vw.isHidden = false
            sign_up_vw.isHidden = true
            sign_in_btn.backgroundColor = Colors.orange
            sign_in_btn.setTitleColor(Colors.white, for: .normal)
            sign_up_btn.setTitleColor(Colors.light_grey_clr, for: .normal)
            sign_up_btn.backgroundColor = Colors.white
            //navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        }*/
        
         navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
    }
    
    @objc func forgot_password_clicked(_ sender:UIButton){
        
        print("Forgot password button clicked")
         navv.Navigation_redirecting_page(_Pagename: "forgot_password_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
    }
    
    @objc func fb_btn_clicked(_ sender:UIButton){
        
        print("facebook button clicked")
        // navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
    }
    
    @objc func googlebtn_clicked(_ sender:UIButton){
        
        print("Google button clicked")
        // navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
    }
    
    @objc func sign_in_btn_clicked(_ sender: UIButton){
        print("Signin button clicked")
        
        sign_in_vw.isHidden = false
        sign_up_vw.isHidden = true
        sign_in_btn.backgroundColor = Colors.orange
        sign_in_btn.setTitleColor(Colors.white, for: .normal)
        sign_up_btn.setTitleColor(Colors.light_grey_clr, for: .normal)
        sign_up_btn.backgroundColor = Colors.white
        
        
    }
    
    @objc func sign_up_btn_clicked(_ sender: UIButton){
        print("Signup button clicked")
        
        sign_in_vw.isHidden = true
        sign_up_vw.isHidden = false
        sign_up_btn.setTitleColor(Colors.white, for: .normal)
        sign_up_btn.backgroundColor = Colors.orange
        sign_in_btn.backgroundColor = Colors.white
        sign_in_btn.setTitleColor(Colors.light_grey_clr, for: .normal)
        
    }
  
    var statusBarHidden = false
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
