//
//  LoginViewController.swift
//  MAP2-20201
//
//  Created by semin on 2020/06/14.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftSoup

class LoginViewController : UIViewController {

    @IBOutlet weak var studentNumberField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwdField: UITextField!
    
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
    }
    
    @IBAction func Login(_ sender: Any) {
        let id = idField.text
        let passwd = passwdField.text
        let idStr = id ?? ""
        let passwdStr = passwd ?? ""
        Person_Info._id = idStr
        Person_Info._passwd = passwdStr
        
        Login()
        
        
        
        
    }
    
    func Login(){
        Person_Info.shared.try_login{result in
            switch result{
            case .success(let cookies):
                print("success")
                //print(cookies)
                Person_Info.shared.cookie = cookies
                Person_Info.shared.setCookies(cookies : cookies)
                Person_Info.shared.login_status = true
                let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
                // B 컨트롤러 뷰로 넘어간다.
//                self.dismiss(animated: true, completion: nil)
                mainVC?.modalTransitionStyle = .coverVertical
                mainVC?.modalPresentationStyle = .fullScreen
                self.present(mainVC!, animated: true, completion: nil)
                
                break
                
            case .failure(let error):
                print("false")
             //   Person_Info.shared.login_status = false
                print("error : \(error)")
                self.showToast(controller: self, message: "아이디 비밀번호를 확인해 주세요", seconds: 1.0)
                
                break
            }
        }
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    //Toast Message
    //How To Use : showToast(controller: self, message : "This is a test", seconds: 2.0)
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 1
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }


    
    
    
}
