//
//  edit_profile_page.swift
//  Fish_Buddy
//
//  Created by o3sa on 24/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import UnderLineTextField
@available(iOS 12.0, *)
class edit_profile_page: UIViewController,UITextViewDelegate,UITextFieldDelegate {

    var main_view: UIView!
    var _viewBtn: UIButton!
    var ph_arr = ["First Name","Last Name","Email","Phone Number","Address"]
    var txt: UnderLineTextField!
    var about_txt: UITextView!
    var upload_txt: UnderLineTextField!
    var submit_btn: UIButton!
    var txt_apnd_arr = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.sidemenu_cross_btn), name: NSNotification.Name(rawValue: "Closing_sidemenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.open_close_menu), name: NSNotification.Name(rawValue: "open_close_btn"), object: nil)
        
        initialization()
        
    }
    
    func initialization(){
        
        Stored.width = self.view.frame.size.width
        Stored.height = self.view.frame.size.height
        
        //NAVIGATION
        navv.intilization(self_: self)
        navv.nav_main_view = self.view;
        
        navv.Nav_View_with_back_btn(_title: "Edit Profile", back_page: "profile_pg", back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
       
        //MAIN VIEW
        main_view = Views.Main_view_without_btm_bar(_subViewIn: self.view, _y: ui.add_y_pos(o: navv.back_view, s: 0))

        main_view.backgroundColor = UIColor.yellow
        design_initialization()
        
        
    }
    
    func design_initialization(){
        
        for i in 0..<ph_arr.count {
            
            txt = Textfields.underline_txt_fld(x: 15, y: 20, w: ui.get_w(o: main_view) - 30, h: 60, ph_hldr: ph_arr[i], tag: i, sbv: main_view)
            txt_apnd_arr.append(txt)
            
            Stored.y_pos = CGFloat(i) * CGFloat(txt.frame.size.height)
            txt.frame.origin.y = Stored.y_pos + 20
            
            if(i == 2){
                txt.keyboardType = .emailAddress
            }
            
            if(i == 3){
                txt.keyboardType = .numberPad
            }
            
        }
        
        about_txt = Textfields.txt_view_(_x: 15, _y: ui.add_y_pos(o: txt, s: 0), _w: ui.get_w(o: main_view)-30, _h: 100, text: "About", _tag: 1, _txtclr: Colors.light_grey_clr, _sv: main_view)
        about_txt.delegate = self
        
        
        upload_txt = Textfields.underline_txt_fld(x: 15, y: ui.add_y_pos(o: about_txt, s: 10), w: ui.get_w(o: main_view) - 30, h: 60, ph_hldr: "Upload Profile Picture", tag: 2, sbv: main_view)
        upload_txt.delegate = self
        
        submit_btn = Buttons.long_btn(x: 15, y: ui.add_y_pos(o: upload_txt, s: 25), w: ui.get_w(o: main_view)-30, _title: "Submit", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: main_view)
        submit_btn.addTarget(self, action: #selector(submit_btn_clicked(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func submit_btn_clicked(_ sender: UIButton){
        
        print("Submit button clicked")
        
    }
    
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.frame.origin.y = -180
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame.origin.y = 0
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        about_txt.underlined(border_clr: Colors.orange)
        if (about_txt.text! == "About") {
            about_txt.text = ""
            about_txt.textColor = Colors.black
            self.view.frame.origin.y = -80
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        about_txt.underlined(border_clr: Colors.gray_clr)
        if (about_txt.text! == "") {
            about_txt.text = "About"
            about_txt.textColor = Colors.gray_clr
            self.view.frame.origin.y = 0
        }
    }

    func closeView_generate() {
        
        _viewBtn = ui.Btn_generate(_x: Stored.width/2, _y: 0, _width: Stored.width/2, _height: Stored.height, _titl_txt: "", titl_color: UIColor.clear, _titl_font: 0, _titl_fnt_String: "")
        _viewBtn.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        _viewBtn.addTarget(self, action: #selector(self.menuOpenClose(_:)), for: .touchUpInside)
        self.view.addSubview(_viewBtn)
        
    }
    
    @objc func open_close_menu() {
        
        delayWithSeconds(0.35) {
            
            self.closeView_generate()
            print("open or close")
        }
    }
    
    @objc func sidemenu_cross_btn(){
        
        print("opening mode")
        _viewBtn.isHidden = true
        print("close mode")
        
    }
    
    @IBAction func menuOpenClose(_ sender: UIButton) {
        
        toggleSideMenuView()
        sender.isHidden = true
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    var statusBarHidden = false
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
