//
//  Person_Info.swift
//  MAP2-20201
//
//  Created by pcrmcw0486 on 2020/04/27.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import Alamofire
import SwiftSoup

//swift getter setter는 프로퍼티를 사용한다.
/*참조 : https://medium.com/ios-development-with-swift/%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0-get-set-didset-willset-in-ios-a8f2d4da5514*/

public class Person_Info
{
    
    static let shared = Person_Info()
     var login_status : Bool = false
     lazy var cookie : [HTTPCookie] = []
    private var _name : String = ""
    private var _id : String = ""
    private var _passwd : String = ""
    private var _student_num : String = ""
    
    private init()
    {}
    
    //yes에 로그인 쿠키 받아오기.
    //completionHandler: @escaping ()-> Void
    func try_login(completionHandler : @escaping (Result<[HTTPCookie], Error>) -> Void)
    {
        //로그인 다시 할때 false로 하고 새로 쿠키 받아옴.(좀 더 생각)
        
        //self.login_status = false
//        let ID = "wan2good"
//        let PW = "wan2good!@"
        let ID = "wan2good"
        let PW = "cjswl1256z!@"
//          let ID = "shs960501"
//          let PW = "song5961!"
        let parameter = [
            "user.usr_id" : ID,
            "user.passwd" : PW
        ]
        
        //var output : String
        AF.request("http://abeek.knu.ac.kr/Keess/comm/support/login/login.action", method: .post, parameters: parameter).responseString{ response in
            switch response.result
            {
            case .success( _) :
                do{
                    let html = try response.result.get()
                    var document : Document = Document.init("")
                    document = try SwiftSoup.parse(html)
                    let elements : Elements = try document.select("#loginBtn")
                    if(elements.isEmpty())
                    {
                        print("로그인 성공")
                        self.login_status = true
                        if let headerFields = response.response?.allHeaderFields as? [String : String]{
                            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: (response.request?.url!)!)
                            completionHandler(.success(cookies))
                        }
                    }
                    else{
                        print("로그인 실패")
                        let login_Error = NSError(domain: "", code: 111, userInfo: [NSLocalizedDescriptionKey: "login_fail"])
                        completionHandler(.failure(login_Error))
                    }
                    
                }catch{
                    
                }
                
                break
            case .failure(let error) :
                completionHandler(.failure(error))
                break
                
            }
        }
    }
    
    func login()
    {
        try_login{result in
            switch result{
            case .success(let cookies):
                self.login_status = true
                print("success")
                //print(cookies)
                Person_Info.shared.cookie = cookies
               self.setCookies(cookies : cookies)
                break
            case .failure(let error):
                print("false")
             //   Person_Info.shared.login_status = false
                print("error : \(error)")
                break
            }
        }
    }
    func setCookies(cookies : [HTTPCookie])
    {
        if(Person_Info.shared.login_status)
        {
          //  let configuration = URLSessionConfiguration.af.default
           // print(cookies)
            print("setCookies : ")
            for cookie in Person_Info.shared.cookie
            {
                AF.session.configuration.httpCookieStorage?.setCookie(cookie)
            }
            print(Person_Info.shared.login_status)
            //print(AF.session.configuration.httpCookieStorage?.cookies ?? "XX")
          // Crawler.shared.grade_crawl(category: 0)
        }
    }
    
}

