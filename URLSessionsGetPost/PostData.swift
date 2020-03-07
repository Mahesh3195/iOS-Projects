//
//  PostData.swift
//  NSUrlSessionTableview
//
//  Created by K Mahesh on 15/12/1941 Saka.
//  Copyright © 1941 K Mahesh. All rights reserved.
//

import UIKit

class PostData: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txt_Title: UITextField!
    @IBOutlet weak var TitleBody: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        txtID.delegate = self
        txt_Title.delegate = self
        TitleBody.delegate = self
        }
    
    @IBAction func postUserData(_ sender: Any) {
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid
        guard let uid = self.txtID.text else { return }
        guard let title = self.txt_Title.text else { return }
        guard let body = self.TitleBody.text else { return }
        
        let parameters = ["userId": uid, "title": title, "body": body] as [String : Any]
        print(parameters)
        
        //create the url with URL
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
        txtID.text = ""
        txt_Title.text = ""
        TitleBody.text = ""
    }
    
   
    
    
    
}
