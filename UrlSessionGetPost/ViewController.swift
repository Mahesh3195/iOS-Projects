//
//  ViewController.swift
//  UrlSessionGetPost
//
//  Created by K Mahesh on 17/12/1941 Saka.
//  Copyright © 1941 K Mahesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var Display_tbl: UITableView!
    var res_count:Int!
    var res = [NSDictionary]()
    var data_arr:NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPostMethod()
        Display_tbl.delegate = self
        Display_tbl.dataSource = self
        //Display_tbl.backgroundColor = UIColor.yellow
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return res.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailsTableViewCell
        cell.Title_lbl.text = res[indexPath.row].value(forKey: "first_name") as! String?
        cell.detail_lbl.text = res[indexPath.row].value(forKey: "last_name") as! String?
        if let image = getImage(from: res[indexPath.row].value(forKey: "avatar") as! String) {
            //5. Apply image avatar
            cell.detail_imv.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func setUpPostMethod(){
        if let url = URL(string: "https://reqres.in/api/users?page=2"){
            var request = URLRequest(url: url)
            //request.httpMethod = "GET"
            
            //request.httpBody =
            
            URLSession.shared.dataTask(with: request) { (data,response,error) in
                guard let data = data else {
                    if error == nil {
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        //print("Status Code :- \(response.statusCode)")
                        //print(response)
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let dict = (json as! NSDictionary)
                    
                    let result = (dict as AnyObject).value(forKey: "data") as! [NSDictionary]
                    self.res = result
                    self.res_count = result.count;
                    print(result)
                    //print(self.res_count!)
                    
                    self.Display_tbl.reloadData()
                    
                }catch let error {
                    print(error.localizedDescription)
                }
                }.resume()
            
        }
    }
    
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }
        
        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])
            
            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return image
    }
    
    //1. Get valid string  Not required in this Project
    let img_url = "https://images.freeimages.com/images/large-previews/f2c/effi-1-1366221.jpg"
    
    
    
}



