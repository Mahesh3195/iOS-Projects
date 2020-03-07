//
//  scan_page.swift
//  Fish_Buddy
//
//  Created by o3sa on 28/09/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import AVFoundation
@available(iOS 12.0, *)
class scan_page: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var _width: CGFloat = 0
    var _height: CGFloat = 0
    var nav: Navigation!
    var ui: uicontroller!
    var scan_vw: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui = uicontroller()
        nav = Navigation()
        
        _width = self.view.frame.size.width
        _height = self.view.frame.size.height
        navv.intilization(self_: self)
        self.sideMenuController()?.sideMenu?.allowLeftSwipe = false
        self.sideMenuController()?.sideMenu?.allowRightSwipe = false
        add_active_indication();
        showActivity_indicatror();
        //intilization();
        design_initialization();
    }
    
    func intilization(){
        
        self.view.backgroundColor = UIColor.black
        
        
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            
            self.camera_view()
            
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    self.camera_view()
                    
                } else {
                    //access denied
                    self.presentCameraSettings()
                }
            })
        }
        
    }
    
    func design_initialization(){
        
        self.view.backgroundColor = UIColor.black
        
        let lbl = Lables.Avenir_Book_med_lbl_25(x: 0, y: 70, _wid: self._width, hei: 30, title: "Largemouth bass", title_clr: Colors.white, _sv: self.view)
        lbl.textAlignment = .center
        
        let img_btn = Buttons.btn_img(_x: self._width - 110, _y: 65, _wid: 20, _hei: 20, bg_clr: Colors.Clear_color(), ImgName: "logout.png", msk_clr: Colors.white, sbv: self.view)
        img_btn.addTarget(self, action: #selector(btn_clkd(_:)), for: .touchUpInside)
        
        
        scan_vw = Views.cust_view(_x: 0, y: ui.add_y_pos(o: lbl, s: 20), w: self._width, _h: 380, bgcolor: UIColor.white, _sbv: self.view)
        
        /*if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            
            self.camera_view()
            
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //access allowed
                    self.camera_view()
                    
                } else {
                    //access denied
                    self.presentCameraSettings()
                }
            })
        }*/
        
        /*let cross_btn: UIButton = self.ui.Btn_generate(_x: 0, _y: 20, _width: 35, _height: 35, _titl_txt: "", titl_color: UIColor.clear, _titl_font: 11, _titl_fnt_String: "")
        cross_btn.addTarget(self, action: #selector(scan_page.cross_btn_clkd(_:)), for: .touchUpInside)
        cross_btn.frame.origin.x = self.view.frame.size.width - 40
        self.view.addSubview(cross_btn)
        
        //CROSS BUTTON IMAGE
        let cross_btn_imv = UIImageView(frame: CGRect(x: 8.75, y: 15, width: 17.5, height: 17.5))
        cross_btn_imv.image = UIImage(named: "close_button.png")?.maskWithColor(color: UIColor.white)
        cross_btn_imv.contentMode = .scaleAspectFit
        cross_btn.addSubview(cross_btn_imv)*/
 
        let imp_lbl = Lables.Avenir_Book_med_lbl_16(x: 0, y: self._height - 145, _wid: self._width, hei: 25, title: "IMPORTANT", title_clr: Colors.orange, _sv: self.view)
        imp_lbl.textAlignment = .center
        
        let capture_lbl = Lables.Avenir_Book_lbl_14(x: 0, y: self._height - 120, _wid: self._width, hei: 25, title: "Capture the entire Fish inside the box", title_clr: Colors.gray_clr, _sv: self.view)
        capture_lbl.textAlignment = .center
        
        let post_btn = Buttons.long_btn(x: 15, y: self._height - 65, w: self._width - 30, _title: "Post", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: self.view)
        post_btn.addTarget(self, action: #selector(scan_page.cross_btn_clkd(_:)), for: .touchUpInside)
        
    }
    
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "",
                                                message: "Camera access required for products barcode scaning!",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })
        
        present(alertController, animated: true)
    }
    
    func camera_view() {
        
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                
                guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
                let videoInput: AVCaptureDeviceInput
                
                do {
                    videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
                } catch {
                    return
                }
                
                if (self.captureSession.canAddInput(videoInput)) {
                    self.captureSession.addInput(videoInput)
                } else {
                    self.failed()
                    return
                }
                
                let metadataOutput = AVCaptureMetadataOutput()
                
                if (self.captureSession.canAddOutput(metadataOutput)) {
                    self.captureSession.addOutput(metadataOutput)
                    
                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    metadataOutput.metadataObjectTypes = [.qr, .code128, .ean13, .ean8, .code39, .pdf417]
                } else {
                    self.failed()
                    return
                }
                
                self.showActivity_indicatror();
                self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                self.previewLayer.frame = CGRect(x: 0, y: 0, width: self.ui.get_w(o: self.scan_vw), height: self.ui.get_h(o: self.scan_vw)) //self.view.layer.bounds
                self.previewLayer.videoGravity = .resizeAspectFill
                self.view.layer.addSublayer(self.previewLayer);
                
                /*
                let lbl = Lables.Avenir_Book_med_lbl_20(x: 0, y: 70, _wid: self._width, hei: 30, title: "Largemouth bass", title_clr: Colors.white, _sv: self.view)
                lbl.textAlignment = .center
                
                let img_btn = Buttons.btn_with_img(x: self._width - 80, y: 60, w: 20, title_txt: "", img_name: "", title_clr: Colors.Clear_color(), msk_clr: Colors.white, bgClr: Colors.Clear_color(), sbv: self.view)
                img_btn.addTarget(self, action: #selector(scan_page.cross_btn_clkd(_:)), for: .touchUpInside)
                
                let cross_btn: UIButton = self.ui.Btn_generate(_x: 0, _y: 20, _width: 35, _height: 35, _titl_txt: "", titl_color: UIColor.clear, _titl_font: 11, _titl_fnt_String: "")
                cross_btn.addTarget(self, action: #selector(scan_page.cross_btn_clkd(_:)), for: .touchUpInside)
                cross_btn.frame.origin.x = self.view.frame.size.width - 40
                self.view.addSubview(cross_btn)
                
                //CROSS BUTTON IMAGE
                let cross_btn_imv = UIImageView(frame: CGRect(x: 8.75, y: 15, width: 17.5, height: 17.5))
                cross_btn_imv.image = UIImage(named: "close_button.png")?.maskWithColor(color: UIColor.white)
                cross_btn_imv.contentMode = .scaleAspectFit
                cross_btn.addSubview(cross_btn_imv)
                
                
                //SCAN PRODUCT
                let scan_lbl = Lables.Avenir_Book_lbl_15(x: 0, y: 70, _wid: Stored.width, hei: 30, title: "SCAN Product", title_clr: Colors.white, _sv: self.view)
                scan_lbl.textAlignment = .center
                
                let imp_lbl = Lables.Avenir_Book_med_lbl_16(x: 0, y: self._height - 105, _wid: self._width, hei: 25, title: "IMPORTANT", title_clr: Colors.orange, _sv: self.view)
                imp_lbl.textAlignment = .center
                
                let capture_lbl = Lables.Avenir_Book_lbl_14(x: 0, y: self._height - 85, _wid: self._width, hei: 25, title: "Capture the entire Fish inside the box", title_clr: Colors.gray_clr, _sv: self.view)
                capture_lbl.textAlignment = .center
                
                let post_btn = Buttons.long_btn(x: 15, y: self._height - 60, w: self._width - 30, _title: "Post", title_Clr: Colors.white, bg_clr: Colors.orange, sbv: self.view)
                */
            }
        }
        
        hideActivity_indicatror();
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        captureSession = AVCaptureSession();
        captureSession.startRunning()
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        captureSession.stopRunning()
        super.viewWillDisappear(animated)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            
            //showActivity_indicatror()
            //call_get_product_details_service(_customer_id: Stored.User_id, _product_id: "", _barcode: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func cross_btn_clkd(_ sender:UIButton)
    {
        navv.Navigation_redirecting_page(_Pagename: "log_catch_pg", _nav: sideMenuController() as! SideMenuNavigationController)
        print("cross btn clk")
    }
    
    @IBAction func btn_clkd(_ sender:UIButton)
    {
        print("Button clicked")
        pop.intilization(parent_view: self.view)
        pop.log_catch_details_popup(w: Stored.width - 30, h: 550)
    }
    
    @IBAction func continue_scan(_ sender: UIButton) {
        pop.PopUpView.isHidden = true
        captureSession.startRunning()
    }
    
    @IBAction func close_scan(_ sender: UIButton) {
        pop.PopUpView.isHidden = true
        navv.Navigation_redirecting_page(_Pagename: "runs_pg", _nav: sideMenuController() as! SideMenuNavigationController)
    }
    
    // custom alert methods
    func alertYEs_no_method(_titel:String,_Content:String){
        
        let alert = UIAlertController(title: _titel, message: _Content, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: doSomething))
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: close_scanner))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func doSomething(action: UIAlertAction) {
        captureSession.startRunning()
    }
    
    func close_scanner(action: UIAlertAction) {
        navv.Navigation_redirecting_page(_Pagename: "Home_pg", _nav: sideMenuController() as! SideMenuNavigationController)
    }
    
    
}
