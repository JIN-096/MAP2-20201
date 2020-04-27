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
        /*do {
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
         }*/
        //사용법 크롤러 싱글톤이라서 shared로 받아서 function실행
        //기본으로 받을때 url은 nil로 줘도됨. 이거 나중에 바꿀꺼 같긴한데
        // 다음페이지 이런거 할때 어떻게 할지 고민중. 그래서 일단 파라미터 optional로 해둠.
        //기본 사용법은 밑과 같을 거 같음.
        
//        print("< knu.ac.kr 본관공지 >\n\n")
//        let main_notice : [Notice]? = Crawler.shared.knu_notice_crawl(URL: nil)
//        for data in main_notice!
//        {
//            print("본관공지 : " + data.title)
//        }
//        print("본관공지 end")
//        print("===============================")
//        print("===============================")
//        print("< computer.knu.ac.kr 전체 공지 >\n\n")
//        let total_notice : [Notice]? = Crawler.shared.computer_total_notice_crawl(URL: nil)
//        for data in total_notice!{
//            print("전체공지 : " + data.title)
//        }
//        print("전체공지 end")
//        print("===============================")
//        print("===============================")
//        print("< computer.knu.ac.kr 학부 공지 >")
//        let major_notice : [Notice]? = Crawler.shared.computer_major_notice_crawl(URL: nil)
//        for data in major_notice!
//        {
//            print("학부공지 : " + data.title)
//        }
//        print("학부공지 end")
//        print("===============================")
        Crawler.shared.academic_calendar_crawl()
        // Do any additional setup after loading the view.
    }
    
    
}

