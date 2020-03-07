//
//  log_catch_page.swift
//  FishBuddy
//
//  Created by o3sa on 20/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
@available(iOS 12.0, *)

class log_catch_page: UIViewController,TableDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var main_view: UIView!
    var _viewBtn: UIButton!
    var btns_arr:[(String,String)] = [("fishing-spots.png","Fishing Sports"),("fish-breads.png","Fish Breeds"),("guide.png","Guide"),("popular.png","Popular")]
    var btns_vw:UIView!
    
    var log_catch_tbl: Custom_tableview!
    var log_catch_count_tbl = ["test","test","test","test"]
    var Image_type:String = "";
    var imag_file_name = ""
    var imageData:NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.sidemenu_cross_btn), name: NSNotification.Name(rawValue: "Closing_sidemenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.open_close_menu), name: NSNotification.Name(rawValue: "open_close_btn"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.coment_clicked), name: NSNotification.Name(rawValue: "Comment_btn_clicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.share_btn_clicked), name: NSNotification.Name(rawValue: "Share_button"), object: nil)
        
        initialization()
        
    }
    
    
    func initialization(){
        
        Stored.width = self.view.frame.size.width
        Stored.height = self.view.frame.size.height
        
        //NAVIGATION
        navv.intilization(self_: self)
        navv.nav_main_view = self.view;
        
        navv.Nav_View_with_btns(_title: "Fish Buddy",back_page: "", back_obj: sign_in_page())
        
        navv.menu_btn.isHidden = false
        self.view.addSubview(navv.Nav_view)
        
        navv.btm_bar(bl_hlht_btn_text: "Log Catch")
        self.view.addSubview(navv.btm_view)
        
        //MAIN VIEW
        main_view = Views.Main_view(_subViewIn: self.view,_x:0, _y: ui.add_y_pos(o: navv.Nav_view, s: 0))
        //main_view.backgroundColor = UIColor.yellow
        
        design_initialization()
       
        
    }
    
    func design_initialization(){
    
        btns_vw = Views.cust_view(_x: 0, y: 0, w: ui.get_w(o: main_view), _h: 80, bgcolor: UIColor.yellow, _sbv: main_view)
        
        if(Stored.Device == "iPad"){
            btns_vw.frame.size.height = 120
        }
        
        for i in 0..<btns_arr.count{
            
            let btn = Buttons.plane_btn(x: 0, y: 0, w: ui.get_w(o: btns_vw)/4, h: ui.get_h(o: btns_vw), sbv: btns_vw)
            btn.tag = i
            btn.backgroundColor = Colors.orange
            btn.addTarget(self, action: #selector(btn_clicked(_:)), for: .touchUpInside)
            
            let imv = Imagevws.bg_imv(_x: 0, _y: 10, _w: 40, _h: 40, _imgName: btns_arr[i].0, _sbvw: btn)
            imv.center.x = btn.frame.size.width/2
          
            let lbl = Lables.Avenir_Book_lbl_12(x: 0, y: ui.add_y_pos(o: imv, s: 5), _wid: ui.get_w(o: btn), hei: 15, title: btns_arr[i].1, title_clr: Colors.white, _sv: btn)
            lbl.textAlignment = .center
            
            if(Stored.Device == "iPad"){
                imv.frame.origin.y = 15
                imv.frame.size.width = 55
                imv.frame.size.height = 55
                lbl.frame.size.height = 25
                lbl.frame.origin.y = ui.add_y_pos(o: imv, s: 10)
                lbl.center.x = btn.frame.size.width/2 + 10
            }
            
            
            Stored.x_pos = CGFloat(i) * CGFloat(btn.frame.size.width)
            btn.frame.origin.x = Stored.x_pos
           
        }
        
        //TABLE SETUP
        log_catch_tbl = Custom_tableview();
        log_catch_tbl.delegate = self
        log_catch_tbl._cell = "log_catch_details"
        
        if(Stored.Device == "iPad"){
            log_catch_tbl._row_height = 675
        }else{
            log_catch_tbl._row_height = 475
        }
        log_catch_tbl.setup(_x: 0, _y: ui.add_y_pos(o: btns_vw, s: 0), _width: ui.get_w(o: main_view), _height: ui.get_h(o: main_view) - ui.get_h(o: btns_vw), _bgClr: Colors.app_bg_clr, _tag: 102, scrLbool: true, _sbv: main_view)
        
        log_catch_tbl.data = log_catch_count_tbl;
        log_catch_tbl._tbl.reloadData();
        
    }
    
    func table_didSelect(indexpath: IndexPath, tableview: UITableView) {
        
        print("IndexPath is \(indexpath)")
        navv.Navigation_redirecting_page(_Pagename: "log_catch_inner_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
    }
    
    @objc func btn_clicked(_ sender: UIButton){
        
        if(sender.tag == 0){
            print("Fishing Sports clicked")
            navv.Navigation_redirecting_page(_Pagename: "fishing_spots_pg", _nav: sideMenuController() as! SideMenuNavigationController)
          
        }
        
        if(sender.tag == 1){
            print("Fishing Breeds clicked")
            Stored.btn_clicked = "Fish Breeds"
            navv.Navigation_redirecting_page(_Pagename: "fish_breeds_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        }
        
        if(sender.tag == 2){
            print("Guide clicked")
            navv.Navigation_redirecting_page(_Pagename: "guide_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        }
        
        if(sender.tag == 3){
            print("Popular clicked")
            Stored.btn_clicked = "Popular Fish Breeds"
            navv.Navigation_redirecting_page(_Pagename: "fish_breeds_pg", _nav: sideMenuController() as! SideMenuNavigationController)
           
            /*pop.intilization(parent_view: self.view)
            if(Stored.Device == "iPad"){
                pop.log_catch_details_popup(w: Stored.width - 30, h: 700)
            }else{
                pop.log_catch_details_popup(w: Stored.width - 30, h: 550)
            }*/
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
    
    
    @objc func coment_clicked(){
        
        print("Comment btn clicked")
        navv.Navigation_redirecting_page(_Pagename: "comments_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        
    }
    
    @objc func share_btn_clicked(){
        
        let activityVc = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVc, animated: true, completion: nil)
        print("share")
        
        /*let actionSheet: UIAlertController = UIAlertController(title: "Choose Image Selection", message: "Option to select", preferredStyle: .actionSheet)
         
         let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
         print("Cancel")
         }
         actionSheet.addAction(cancelActionButton)
         
         let saveActionButton = UIAlertAction(title: "Pick From Gallery", style: .default)
         { _ in
         self.Image_type = "gallery";
         self.selectPicture(num:1);
         }
         actionSheet.addAction(saveActionButton)
         
         let deleteActionButton = UIAlertAction(title: "Pick From Camera", style: .default)
         { _ in
         self.Image_type = "camera";
         self.selectPicture(num:0);
         }
         actionSheet.addAction(deleteActionButton)
         self.present(actionSheet, animated: true, completion: nil)*/
    }
    
    func selectPicture(num:Int) {
        
        
        
        let picker = UIImagePickerController()
        if(num == 0){
            picker.sourceType = UIImagePickerController.SourceType.camera
        }else{
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        }
        picker.allowsEditing = true
        picker.delegate = self ;
        picker.navigationBar.tintColor = UIColor.blue
        picker.navigationBar.barStyle = .blackOpaque
        picker.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.black
        present(picker, animated: true)
        
    }
    

    var statusBarHidden = false
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
}
