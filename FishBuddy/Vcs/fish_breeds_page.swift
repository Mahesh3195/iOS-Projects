//
//  fish_breeds_page.swift
//  FishBuddy
//
//  Created by o3sa on 23/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
@available(iOS 12.0, *)
class fish_breeds_page: UIViewController,CollectionDelegate {
   
    var main_view: UIView!
    var _viewBtn: UIButton!
    var back_page:String = ""
   
    var fishin_breed_cltn: Custom_Collectionview!
    var imgs_arr = ["test","test","test","test","test","test","test","test","test","test"]
    var header_title:String!
    
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
      
        if(Stored.btn_clicked == "Catches"){
             back_page = "profile_pg"
        }else{
             back_page = "log_catch_pg"
        }
        navv.Nav_View_with_back_btn(_title: Stored.btn_clicked, back_page: back_page, back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
       
        //MAIN VIEW
        main_view = Views.Main_view_without_btm_bar(_subViewIn: self.view,_y: ui.add_y_pos(o: navv.back_view, s: 0))
        //main_view.backgroundColor = UIColor.yellow
        
        design_initialization()
        
        
    }
    
    
    func design_initialization(){
        
        fishin_breed_cltn = Custom_Collectionview();
        fishin_breed_cltn.delegate = self
        fishin_breed_cltn._cell = "fishing_breeds_coltn_cell"
        
        if(Stored.Device == "iPad"){
             fishin_breed_cltn.set_layout(top_val: 5, left_val: 0, bottom_val: 0, right_val: 0, item_width: ui.get_w(o: main_view)/2-5, item_height: 225, min_lineSpace: 10, min_IntrSpace: 10, scr_dirction: .vertical)
        }else{
             fishin_breed_cltn.set_layout(top_val: 5, left_val: 0, bottom_val: 0, right_val: 0, item_width: ui.get_w(o: main_view)/2-2.5, item_height: 135, min_lineSpace: 5, min_IntrSpace: 0, scr_dirction: .vertical)
        }
        
        fishin_breed_cltn.setup(_x: 0, _y: 0, _width: ui.get_w(o: main_view), _height: ui.get_h(o: main_view), _bgClr: Colors.Clear_color(), _tag: 101)
        
        fishin_breed_cltn.data = imgs_arr;
        fishin_breed_cltn._coll.reloadData();
        
        main_view.addSubview(fishin_breed_cltn._coll)
      
    }
    
    func collection_didSelect(index: Int, collectionview: UICollectionView) {
        
        if(Stored.btn_clicked == "Fish Breeds"){
            
            pop.intilization(parent_view: self.view)

            if(Stored.Device == "iPad"){
                pop.fish_breed_popup(w: Stored.width - 30, h: 700)
            }else{
                pop.fish_breed_popup(w: Stored.width - 30, h: 550)
            }
            
        }else{
             print("IndexPath: \(index)")
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
