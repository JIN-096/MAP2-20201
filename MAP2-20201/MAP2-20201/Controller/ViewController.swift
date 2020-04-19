//
//  ViewController.swift
//  MAP2-20201
//
//  Created by Semin on 2020/04/15.
//  Copyright © 2020 COMP420. All rights reserved.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let urlPath = "http://knu.ac.kr/wbbs/wbbs/bbs/btin/list.action?bbs_cde=1&menu_idx=67"
            let url = NSURL(string: urlPath)
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url! as URL, completionHandler: {
                (data,response,error) ->Void in
                if error == nil{
                    let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print(urlContent ?? "No contents Found")
                }else{
                    print(error ?? "no error")
                    print("Error occured")
                }
            })
            task.resume()
            let html = ""
            let doc : Document = try SwiftSoup.parse(html)
            print(doc)
            
        } catch{
            print("")
        }
        // Do any additional setup after loading the view.
    }


}

