//
//  fishing_spots_page.swift
//  FishBuddy
//
//  Created by o3sa on 21/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
@available(iOS 12.0, *)
class fishing_spots_page: UIViewController,TableDelegate {
    
    var main_view: UIView!
    var _viewBtn: UIButton!
    var fishing_spots_tbl: Custom_tableview!
    var spots_count_tbl = ["test","test","test","test"]
    
    
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
        
        navv.Nav_View_with_back_btn(_title: "Fishing Spots", back_page: "log_catch_pg", back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
        
        navv.btm_bar(bl_hlht_btn_text: "Log Catch")
        self.view.addSubview(navv.btm_view)
        
        //MAIN VIEW
        main_view = Views.Main_view(_subViewIn: self.view,_x:0, _y: ui.add_y_pos(o: navv.back_view, s: 0))
        
        design_initialization()
        
        
    }
    
    func design_initialization(){
        
        //TABLE SETUP
        fishing_spots_tbl = Custom_tableview();
        fishing_spots_tbl.delegate = self
        fishing_spots_tbl._cell = "fishing_spots_details"
        if(Stored.Device == "iPad"){
            fishing_spots_tbl._row_height = 185
        }else{
            fishing_spots_tbl._row_height = 165
        }
        
        fishing_spots_tbl.setup(_x: 0, _y: 0, _width: ui.get_w(o: main_view), _height: ui.get_h(o: main_view), _bgClr: Colors.app_bg_clr, _tag: 101, scrLbool: true, _sbv: main_view)
        
        fishing_spots_tbl.data = spots_count_tbl;
        fishing_spots_tbl._tbl.reloadData();
        
    }
    
    func table_didSelect(indexpath: IndexPath, tableview: UITableView) {
        
        print("IndexPath is \(indexpath)")
        navv.Navigation_redirecting_page(_Pagename: "fishing_spots_inner_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
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
