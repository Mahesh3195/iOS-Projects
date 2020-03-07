//
//  followers_inner_page.swift
//  Fish_Buddy
//
//  Created by o3sa on 30/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import GoogleMaps

@available(iOS 12.0, *)
class followers_inner_page: UIViewController,CollectionDelegate {
    
    var main_view: UIView!
    var _viewBtn: UIButton!
    var followers_cltn: Custom_Collectionview!
    var imgs_arr = ["test","test","test","test","test","test","test","test","test","test"]
    
    var following_cltn: Custom_Collectionview!
    
    var catches_cltn: Custom_Collectionview!
    
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
        
        navv.Nav_View_with_back_btn(_title: Stored.cell_clicked, back_page: "profile_pg", back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
        
        //MAIN VIEW
        main_view = Views.Main_view_without_btm_bar(_subViewIn: self.view, _y: ui.add_y_pos(o: navv.back_view, s: 0))
        
        design_initialization()
        
        
    }
    
    func design_initialization(){
        
        let scrl_view = Views.scrl_View_v(_y: 0, _h: ui.get_h(o: main_view), _ch: 300, _subv: main_view)
        
        let imv = Imagevws.bg_imv(_x: 0, _y: 0, _w: ui.get_w(o: main_view), _h: 200, _imgName: "post-image.png", _sbvw: scrl_view)
        imv.contentMode = .scaleToFill
        
        let edit_btn = Buttons.small_btn(x: ui.get_w(o: imv) - (Stored.width/4) - 15, y: ui.get_h(o: imv) - 45, _title: "Follow", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: scrl_view)
        edit_btn.addTarget(self, action: #selector(edit_btn_clicked(_:)), for: .touchUpInside)
        
        if(Stored.Device == "iPad"){
            imv.frame.size.height = 350
            edit_btn.frame.origin.y = ui.get_h(o: imv) - 55
        }
        
        let title_lbl = Lables.Avenir_Book_med_lbl_15(x: 15, y: ui.add_y_pos(o: imv, s: 10), _wid: ui.get_w(o: scrl_view)-30, hei: 20, title: "Thomas Johnson", title_clr: Colors.black, _sv: scrl_view)
        
        let city_lbl = Lables.Avenir_Book_lbl_13(x: 15, y: ui.add_y_pos(o: title_lbl, s: 5), _wid: ui.get_w(o: scrl_view)-30, hei: 20, title: "Ardwick,Manchester,UK", title_clr: Colors.ph_clr, _sv: scrl_view)
        
        let desc_lbl = Lables.Avenir_Book_lbl_13(x: 15, y: ui.add_y_pos(o: city_lbl, s: 0), _wid: ui.get_w(o: scrl_view)-30, hei: 65, title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.", title_clr: Colors.light_black_clr, _sv: scrl_view)
        //desc_lbl.backgroundColor = UIColor.yellow
        ui.word_wrap_lbl(lbl_name: desc_lbl)
        
       let catches_view = Views.cust_view(_x: 15, y: ui.add_y_pos(o: desc_lbl, s: 5), w: ui.get_w(o: scrl_view)-30, _h: 130, bgcolor: Colors.Clear_color(), _sbv: scrl_view)
        
        let catches_lbl = Lables.Avenir_Book_med_lbl_14(x: 0, y: 0, _wid: ui.get_w(o: catches_view)/2, hei: 20, title: "Catches", title_clr: Colors.orange, _sv: catches_view)
        
        let catches_btn = Buttons.right_arw_btn(_x: ui.get_w(o: catches_view)-75, _y: 0, _wid: 75, title: "See All", sbv: catches_view)
        catches_btn.addTarget(self, action: #selector(catches_btn_clicked(_:)), for: .touchUpInside)
        
        catches_cltn = Custom_Collectionview();
        catches_cltn.delegate = self
        catches_cltn._cell = "catches_cltn_cell"
        if(Stored.Device == "iPad"){
            catches_lbl.frame.size.height = 30
            catches_lbl.textAlignment = .left
            catches_btn.frame.size.width = 110
            catches_btn.frame.origin.x = ui.get_w(o: catches_view)-110
            catches_cltn.set_layout(top_val: 0, left_val: 0, bottom_val: 0, right_val: 0, item_width: 170, item_height: 170, min_lineSpace: 5, min_IntrSpace: 0, scr_dirction: .horizontal)
            //followers_cltn._coll.frame.origin.y = 35
            catches_view.frame.size.height = 220
            //catches_view.backgroundColor = UIColor.yellow
        }else{
            catches_cltn.set_layout(top_val: 0, left_val: 0, bottom_val: 0, right_val: 0, item_width: 80, item_height: 100, min_lineSpace: 5, min_IntrSpace: 0, scr_dirction: .horizontal)
        }
        
        catches_cltn.setup(_x: 0, _y: 20, _width: ui.get_w(o: catches_view), _height: 100, _bgClr: Colors.Clear_color(), _tag: 103)
        catches_cltn._coll.showsHorizontalScrollIndicator = false
        
        catches_cltn.data = imgs_arr;
        catches_cltn._coll.reloadData();
        
        catches_view.addSubview(catches_cltn._coll)
        
        if(Stored.Device == "iPad"){
            catches_cltn._coll.frame.origin.y = 30
            catches_cltn._coll.frame.size.height = 170
        }
        
        let catches_map_view = Views.cust_view(_x: 0, y: ui.add_y_pos(o: catches_view, s: 5), w: ui.get_w(o: scrl_view), _h: 230, bgcolor: Colors.Clear_color(), _sbv: scrl_view)
        
        let catches_map_lbl = Lables.Avenir_Book_med_lbl_14(x: 15, y: 0, _wid: ui.get_w(o: catches_map_view)-30, hei: 20, title: "Catches Map", title_clr: Colors.orange, _sv: catches_map_view)
        
        let camera = GMSCameraPosition.camera(withLatitude: 17.346780, longitude: 78.531690, zoom: 16.0)
        
        let mapView = GMSMapView(frame: CGRect(x: 0, y: ui.add_y_pos(o: catches_map_lbl, s: 10), width: ui.get_w(o: scrl_view), height: 200), camera: camera)
        catches_map_view.addSubview(mapView)
        //self.view = mapView // for total screen frame = .zero
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 17.346780, longitude: 78.531690))
        marker.title = "Huda Colony,Saroor Nagar"
        marker.snippet = "Hyderabad,Telangana"
        marker.map = mapView
        
        if(Stored.Device == "iPad"){
            catches_cltn._coll.frame.origin.y = 30
            catches_cltn._coll.frame.size.height = 170
            mapView.frame.size.height = 350
            catches_map_view.frame.size.height = 380
        }
        
        scrl_view.contentSize = CGSize(width: 0, height: ui.get_h(o: imv) + ui.get_h(o: catches_view) + ui.get_h(o: catches_map_view) + 150)
        
    }
    
    @objc func catches_btn_clicked(_ sender: UIButton){
        print("See all button clicked")
        Stored.btn_clicked = "Catches"
        navv.Navigation_redirecting_page(_Pagename: "fish_breeds_pg", _nav: sideMenuController() as! SideMenuNavigationController)
    }
    
   
    
    func collection_didSelect(index: Int, collectionview: UICollectionView) {
        print("IndexPath: \(index)")
    }
    
    @objc func edit_btn_clicked(_ sender: UIButton){
        
        print("edit button clicked")
        navv.Navigation_redirecting_page(_Pagename: "edit_profile_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
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
