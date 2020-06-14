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
    
    // cell click event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi");
    }
}


