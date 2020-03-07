//
//  add_post_page.swift
//  FishBuddy
//
//  Created by o3sa on 20/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import UnderLineTextField
@available(iOS 12.0, *)

class add_post_page: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate {

    var main_view: UIView!
    var _viewBtn: UIButton!
    var upload_txt: UnderLineTextField!
    var add_url_txt: UnderLineTextField!
    var img_arr = [NSMutableDictionary]();
    var tmp_arr = [NSMutableDictionary]();
    var plus_disc:NSMutableDictionary = [:];
    var coment_txt: UITextView!
    var post_btn: UIButton!
    
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
        
        navv.Nav_View_with_back_btn(_title: "Add Post", back_page: "log_catch_pg", back_obj: sign_in_page())
        self.view.addSubview(navv.back_view)
        
        navv.btm_bar(bl_hlht_btn_text: "Add Post")
        self.view.addSubview(navv.btm_view)
        
        //MAIN VIEW
        main_view = Views.Main_view(_subViewIn: self.view,_x:0, _y: ui.add_y_pos(o: navv.back_view, s: 0))
        
        design_initialization()
        
        
    }
    
    func design_initialization(){
        
        upload_txt = Textfields.underline_txt_fld(x: 15, y: 20, w: ui.get_w(o: main_view)-30, h: 60, ph_hldr: "Browse Photo/Video", tag: 1, sbv: main_view)
        
        let btn = Buttons.long_btn(x: 0, y: 0, w: ui.get_w(o: upload_txt), _title: "", title_Clr: Colors.Clear_color(), bg_clr: Colors.Clear_color(), sbv: upload_txt)
        btn.addTarget(self, action: #selector(upload_btn_clicked(_:)), for: .touchUpInside)
        
        let imv = Imagevws.bg_imv(_x: ui.get_w(o: btn)-20, _y: 12, _w: 20, _h: 20, _imgName: "Upload.png", _sbvw: btn)
        
         //upload_txt_fld(x: 15, y: 20, w: ui.get_w(o: main_view)-30, h: 60, ph_hldr: "Browse Photo/Video", sbv: main_view) //upload_txt_fld(x: 15, y: 20, w: ui.get_w(o: main_view)-30, h: 60, ph_hldr: "Browse Photo/Video", sbv: main_view)
        //upload_txt.isUserInteractionEnabled = false
        //upload_txt.addTarget(self, action: #selector(upload_txt_clicked(_:)), for: .editingDidBegin)
        
        add_url_txt = Textfields.underline_txt_fld(x: 15, y: ui.add_y_pos(o: upload_txt, s: 0), w: ui.get_w(o: main_view)-30, h: 60, ph_hldr: "Add URL", tag: 3, sbv: main_view)
        
        coment_txt = Textfields.txt_view_(_x: 15, _y: ui.add_y_pos(o: add_url_txt, s: 0), _w: ui.get_w(o: main_view)-30, _h: 200, text: "Write Comment", _tag: 1, _txtclr: Colors.light_grey_clr, _sv: main_view)
        coment_txt.delegate = self
        
        post_btn = Buttons.long_btn(x: 15, y: ui.add_y_pos(o: coment_txt, s: 20), w: ui.get_w(o: main_view)-30, _title: "Post", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: main_view)
        post_btn.addTarget(self, action: #selector(post_btn_clicked(_:)), for: .touchUpInside)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        coment_txt.underlined(border_clr: Colors.orange)
        if (coment_txt.text! == "Write Comment") {
            coment_txt.text = ""
            coment_txt.textColor = Colors.black
            self.view.frame.origin.y = -50
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        coment_txt.underlined(border_clr: Colors.light_grey_clr)
        if (coment_txt.text! == "") {
            coment_txt.text = "Write Comment"
            coment_txt.textColor = Colors.light_grey_clr
            self.view.frame.origin.y = 0
        }
    }
    
    
    @objc func upload_btn_clicked(_ sender: UIButton){
        
        print("Upload text clicked")
        upload_txt.isUserInteractionEnabled = true
        
        let imagepickerController = UIImagePickerController()
        imagepickerController.delegate = self
        
        let actionsheet: UIAlertController = UIAlertController(title: "Choose Image Selection", message: "Option to select", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Pick From Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.present(imagepickerController, animated: true, completion: nil)
            }else {
                print("camera not available")
            }
            
            imagepickerController.sourceType = .camera
            self.present(imagepickerController, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Pick From Gallery", style: .default, handler: { (action: UIAlertAction) in
            imagepickerController.sourceType = .photoLibrary
            self.present(imagepickerController, animated: true, completion: nil)
            
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel
            , handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        
        dismiss(animated: true, completion: nil)
        pick_img_assing(img:selectedImageFromPicker!);
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func pick_img_assing(img:UIImage){
        
        var normal_:NSMutableDictionary = [:]
        normal_.setValue(img, forKey: "image");
        normal_.setValue("normal", forKey: "type");
        tmp_arr.append(normal_);
        
        img_arr.removeAll();
        
        for i in 0..<tmp_arr.count {
            if(((tmp_arr[i] as AnyObject).value(forKey: "type") as! String) == "normal"){
                img_arr.append(tmp_arr[i]);
            }
        }
        
        img_arr.append(plus_disc);
        
        
        
    }
    
    @objc func post_btn_clicked(_ sender: UIButton){
        
        print("Post button clicked")
        
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
