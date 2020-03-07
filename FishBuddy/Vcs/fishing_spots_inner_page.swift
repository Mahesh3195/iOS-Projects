//
//  fishing_spots_inner_page.swift
//  FishBuddy
//
//  Created by o3sa on 21/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
@available(iOS 12.0, *)
class fishing_spots_inner_page: UIViewController {

    var main_view: UIView!
    var _viewBtn: UIButton!
    var content_arr:[(String,String)] = [("Max.lenghth","18.8 km (11.7 mi)"),("Surface Area","26.7 km2"),("Average depth","87 meters (284 ft)"),("Max depth","310m(1,017ft)"),("water volume","2,3073 cubic km"),("Surface elevation","meters (30ft)")]
    var vw: UIView!
    
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
        
        navv.Nav_View_with_back_btn(_title: "Loch Morar Freshwater Lake", back_page: "fishing_spots_pg", back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
        
        navv.btm_bar(bl_hlht_btn_text: "Log Catch")
        self.view.addSubview(navv.btm_view)
        
        //MAIN VIEW
        main_view = Views.Main_view(_subViewIn: self.view,_x:0, _y: ui.add_y_pos(o: navv.back_view, s: 0))
        
        design_initialization()
        
        
    }
    
  
    func design_initialization(){
        
        let scrl_view = Views.scrl_View_v(_y: 0, _h: ui.get_h(o: main_view), _ch: 200, _subv: main_view)
        
        let imv = Imagevws.bg_imv(_x: 0, _y: 0, _w: ui.get_w(o: main_view), _h: 240, _imgName: "post-image.png", _sbvw: scrl_view)
        imv.contentMode = .scaleToFill
        
        if(Stored.Device == "iPad"){
            imv.frame.size.height = 400
        }
        
        let description_lbl = Lables.Avenir_Book_lbl_13(x: 10, y: ui.add_y_pos(o: imv, s: 10), _wid: ui.get_w(o: main_view) - 20, hei: 150, title: "Loch Morar is 18.8 kilometres (11.7 mi) long, has a surface area of 26.7 km2 (10.3 sq mi), and is the deepest freshwater body in the British Isles with a maximum depth of 310 m (1,017 ft).[1][2] In 1910, John Murray and Laurence Pullar found it to have a mean depth of 87 metres (284 ft) and a total volume of 2.3073 cubic kilometres (81,482,000,000 cu ft) during their survey of Scottish lochs.[3] The bottom is deepened below the United Kingdom Continental Shelf.", title_clr: Colors.light_black_clr, _sv: scrl_view)
        //description_lbl.backgroundColor = UIColor.orange
        ui.word_wrap_lbl(lbl_name: description_lbl)
        
        for i in 0..<content_arr.count{
            
            vw = Views.cust_view(_x: 0, y: 0, w: ui.get_w(o: main_view), _h: 20, bgcolor: Colors.Clear_color(), _sbv: scrl_view)
            
            let title_lbl = Lables.Avenir_Book_lbl_13(x: 10, y: 0, _wid: ui.get_w(o: vw)/3, hei: 20, title: content_arr[i].0, title_clr: Colors.light_black_clr, _sv: vw)
            //title_lbl.backgroundColor = UIColor.yellow
            
            let desc_lbl = Lables.Avenir_Book_lbl_13(x: ui.add_x_pos(o: title_lbl, s: 0), y: 0, _wid: ui.get_w(o: vw)/2-10, hei: 20, title: content_arr[i].1, title_clr: Colors.black, _sv: vw)
            //desc_lbl.backgroundColor = UIColor.orange
            
            Stored.y_pos = CGFloat(i) * CGFloat(vw.frame.size.height + 10)
            vw.frame.origin.y = Stored.y_pos + ui.add_y_pos(o: description_lbl, s: 15)
            
            if(Stored.Device == "iPad"){
                vw.frame.size.height = 30
                title_lbl.frame.size.height = 30
                desc_lbl.frame.size.height = 30
            }
            
        }
        
        let locate_btn = Buttons.btn_with_img(x: 0, y: ui.add_y_pos(o: vw, s: 15), w: ui.get_w(o: main_view)/2, title_txt: "     Locate the Lake", img_name: "facebook-placeholder-for-locate-places-on-maps.png", title_clr: Colors.white, msk_clr: Colors.white, bgClr: Colors.orange, sbv: scrl_view)
        locate_btn.center.x = scrl_view.frame.size.width/2
        locate_btn.addTarget(self, action: #selector(locate_btn_clicked(_:)), for: .touchUpInside)
        if(Stored.Device == "iPad"){
            locate_btn.frame.origin.y = ui.add_y_pos(o: vw, s: 25)
        }
        
        scrl_view.contentSize = CGSize(width: 0, height: ui.get_h(o: imv) + ui.get_h(o: description_lbl) + 260)
    }

    @objc func locate_btn_clicked(_ sender: UIButton){
        
        print("locate button clicked")
        
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
