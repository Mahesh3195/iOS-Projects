//
//  comments_page.swift
//  FishBuddy
//
//  Created by o3sa on 21/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
@available(iOS 12.0, *)
class comments_page: UIViewController,TableDelegate,UITextFieldDelegate {
    
    var main_view: UIView!
    var _viewBtn: UIButton!
    var content_arr:[(String,String)] = [("Max.lenghth","18.8 km (11.7 mi)"),("Surface Area","26.7 km2"),("Average depth","87 meters (284 ft)"),("Max depth","310m(1,017ft)"),("water volume","2,3073 cubic km"),("Surface elevation","meters (30ft)")]
    var vw: UIView!
    var comments_tbl: Custom_tableview!
    var count_tbl = ["test","test","test","test"]
    var coment_txt: UITextField!
    
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
        
        navv.Nav_View_with_back_btn(_title: "Largemouth bass 3.4 Kg", back_page: "log_catch_pg", back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
        
        navv.btm_bar(bl_hlht_btn_text: "Log Catch")
        self.view.addSubview(navv.btm_view)
        
        //MAIN VIEW
        main_view = Views.Main_view(_subViewIn: self.view,_x:0, _y: ui.add_y_pos(o: navv.back_view, s: 0))
        
        design_initialization()
        
        
    }
    
    
    func design_initialization(){
     
        let scrl_vw = Views.scrl_View_v(_y: 0, _h: ui.get_h(o: main_view), _ch: 840, _subv: main_view)
        
        let vw = Views.log_catch_view(x: 0, y: 10, w: ui.get_w(o: main_view), h: 360, social_btn: true, _sbv: scrl_vw)
        
        //TABLE SETUP
        comments_tbl = Custom_tableview();
        comments_tbl.delegate = self
        comments_tbl._cell = "comment_details"
        comments_tbl._row_height = 90
        comments_tbl.setup(_x: 0, _y: ui.add_y_pos(o: vw, s: 0), _width: ui.get_w(o: main_view), _height: 400, _bgClr: Colors.white, _tag: 102, scrLbool: true, _sbv: scrl_vw)
        
        comments_tbl.data = count_tbl;
        comments_tbl._tbl.reloadData();
        
        coment_txt = Textfields.comment_txt(x: 10, _y: ui.add_y_pos(o: comments_tbl._tbl, s: 10), w: ui.get_w(o: main_view)-20, tag: 1, _sbv: scrl_vw)
        coment_txt.delegate = self
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(coment_txt.tag == 1){
            self.view.frame.origin.y = -180
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if(coment_txt.tag == 1){
            self.view.frame.origin.y = 0
           self.view.endEditing(true)
        }
    }
    
    func table_didSelect(indexpath: IndexPath, tableview: UITableView) {
        
        print("IndexPath is \(indexpath)")
        
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
