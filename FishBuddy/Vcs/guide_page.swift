//
//  guide_page.swift
//  FishBuddy
//
//  Created by o3sa on 23/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
@available(iOS 12.0, *)
class guide_page: UIViewController,TableDelegate {
    
    var main_view: UIView!
    var _viewBtn: UIButton!
    var guide_tbl: Custom_tableview!
    var count_tbl = ["test","test","test","test","test"]
    
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
        
        navv.Nav_View_with_back_btn(_title: "Fishing Tips and Tricks", back_page: "log_catch_pg", back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
        
        //MAIN VIEW
        main_view = Views.Main_view_without_btm_bar(_subViewIn: self.view, _y: ui.add_y_pos(o: navv.back_view, s: 0))
        //main_view.backgroundColor = UIColor.yellow
        
        design_initialization()
        
        
    }
    
    func design_initialization(){
        
        let title_lbl = Lables.Avenir_Book_lbl_14(x: 10, y: 10, _wid: ui.get_w(o: main_view)-20, hei: 40, title: "Here are the top 5 fishing tricks and tips to catch fish, no matter what skill level you are at:", title_clr: Colors.orange, _sv: main_view)
        ui.word_wrap_lbl(lbl_name: title_lbl)
        
        //TABLE SETUP
        guide_tbl = Custom_tableview();
        guide_tbl.delegate = self
        guide_tbl._cell = "guide_details"
        if(Stored.Device == "iPad"){
            guide_tbl._row_height = 430
        }else{
            guide_tbl._row_height = 350
        }
        
        guide_tbl.setup(_x: 0, _y: ui.add_y_pos(o: title_lbl, s: 0), _width: ui.get_w(o: main_view), _height: ui.get_h(o: main_view)-55, _bgClr: Colors.white, _tag: 103, scrLbool: true, _sbv: main_view)
        
        guide_tbl.data = count_tbl;
        guide_tbl._tbl.reloadData();
        
        
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
