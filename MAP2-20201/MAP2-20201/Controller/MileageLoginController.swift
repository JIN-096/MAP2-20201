//
//  MileageLoginController.swift
//  MAP2-20201
//
//  Created by semin on 2020/06/14.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftSoup

class MileageLoginController : UIViewController {
    
    @IBOutlet weak var mstudentNumberField: UITextField!
    @IBOutlet weak var midField: UITextField!
    @IBOutlet weak var mpasswdField: UITextField!
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
    }
    @IBAction func mLogin(_ sender: Any) {
        let id = midField.text
        let passwd = mpasswdField.text
        let idStr = id ?? ""
        let passwdStr = passwd ?? ""
        Person_Info._m_id = idStr
        Person_Info._m_passwd = passwdStr
        Login()
    }
    
    func Login(){
        Person_Info.shared.try_mileage_login{result in
            switch result{
            case .success(let cookies):
                Person_Info.shared.mileage_login_status = true
                print("mileage success")
                //print(cookies)
                Person_Info.shared.mileagecookie = cookies
                let url : URL? = URL(string: "http://knusys9.knu.ac.kr/swed/swed/") ?? nil
                AF.session.configuration.httpCookieStorage?.setCookies(cookies, for: url, mainDocumentURL: url)
               //self.setCookies(cookies : cookies)
                var mileageVC = MileageViewController()
                 mileageVC = self.storyboard?.instantiateViewController(withIdentifier: "MileageViewController") as! MileageViewController
                                // B 컨트롤러 뷰로 넘어간다.
                //                self.dismiss(animated: true, completion: nil)
                                
                                self.navigationController?.pushViewController(mileageVC, animated: true)
                break
            case .failure(let error):
                print("mileage false")
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
