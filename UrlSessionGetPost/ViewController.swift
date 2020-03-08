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
    var per_first_name:String!
    var per_last_name:String!
    var per_full_name:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Display_tbl.delegate = self
        Display_tbl.dataSource = self
        //Display_tbl.backgroundColor = UIColor.yellow
        setUpPostMethod()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return res.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailTableViewCell
        cell.Title_lbl.text = res[indexPath.row].value(forKey: "first_name") as! String?
        cell.detail_lbl.text = res[indexPath.row].value(forKey: "last_name") as! String?
        self.per_full_name = "\(cell.Title_lbl.text!) \(cell.detail_lbl.text!)"
        if let image = getImage(from: res[indexPath.row].value(forKey: "avatar") as! String) {
            //5. Apply image avatar
            cell.detail_imv.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CellDetail_pg") as? CellDetail
        
        vc?.name = "\(res[indexPath.row].value(forKey: "first_name") as! String) \(res[indexPath.row].value(forKey: "last_name") as! String)"
        vc?.image = getImage(from: res[indexPath.row].value(forKey: "avatar") as! String)!
        
        self.navigationController?.pushViewController(vc!, animated: true)
        //  print("IndexPath: \(indexPath)")
        
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
                        // print(error?.localizedDescription ?? "Unknown Error")
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
                    //self.res.append(result)
                    self.res_count = result.count;
                    print(result)
                    //print(self.res_count!)
                    
                    for i in self.res {
                        self.per_first_name = i.value(forKey: "first_name") as! String
                        // print(self.per_first_name!)
                    }
                    // self.per_first_name = self.res[0].value(forKey: "first_name") as? String
                    
                    
                }catch let error {
                    print(error.localizedDescription)
                }
                self.Display_tbl.reloadData()
                
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



