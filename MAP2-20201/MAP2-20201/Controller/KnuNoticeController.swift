//
//  TableViewController.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/04/29.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit
class KnuNoticeController : UIViewController{
    
    var Notice_knu : [Notice]? = Crawler.shared.knu_notice_crawl(URL: nil)
//    var myGrade : [Grade]?
   
  //  var semesters : [String]?
     
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(KnuNoticeCell.self, forCellReuseIdentifier: KnuNoticeCell.identifier)
        
       
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableview datasource and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        configure()
        addSubView()
        autoLayout()
//        Crawler.shared.mileage_crawl{ result in
//            switch result {
//            case.success(let mileage):
//                print("success")
//                break
//            case.failure(let error):
//                print("failure")
//                break
//            }
            
       // }
        
        //학기 받아오기
//        Crawler.shared.time_table_semester_crawl{ result in
//            switch result{
//            case .success(let semester):
//                self.semesters = semester
//                for data in self.semesters!{
//                    print(data)
//                }
//                break
//            case .failure(let error):
//                print(error)
//                break
//            }
//        }
    }
    
    private func configure()
    {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func addSubView(){
        view.addSubview(tableView)
    }
    
    private func autoLayout(){
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
    }
    
    
}

extension KnuNoticeController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notice_knu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KnuNoticeCell.identifier, for: indexPath) as! KnuNoticeCell
        cell.notice_num.text = Notice_knu?[indexPath.row].num ?? ""
        cell.notice_title.text = Notice_knu?[indexPath.row].title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        var webViewController = WebViewController()
        let attr = Notice_knu?[indexPath.row].ref.getArrayAfterRegex(regex: "(?<=')[a-zA-Z0-9]*(?=')")
        let param1 : String = attr?[0] ?? ""
        let param2 : String = attr?[1] ?? ""
        let param3 : String = attr?[3] ?? ""
        let baseURL : String = "https://knu.ac.kr/wbbs/wbbs/bbs/btin/stdViewBtin.action?btin.doc_no="+param1+"&btin.appl_no="+param2+"&btin.page=1&btin.search_type=&btin.search_text=&popupDeco=&btin.note_div="+param3+"&menu_idx=42"
        
        
//        baseURL += Notice_knu?[indexPath.row].ref ?? ""
//        print("BASEURL: \(baseURL)")
        webViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        webViewController.myURLString = baseURL
        self.navigationController?.pushViewController(webViewController, animated: true)


        
            
        
    }
}


