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
    var myGrade : [Grade]?
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(KnuNoticeCell.self, forCellReuseIdentifier: KnuNoticeCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubView()
        autoLayout()
      
//        Crawler.shared.grade_crawl(category: 0){ result in
//            switch result {
//            case .success(let grade) :
//                self.myGrade = grade
//                for data in self.myGrade!{
//                    print("\(data.code) \(data.open_department) \(data.name) \(data.type) \(data.grade_unit) \(data.semester) \(data.rating) \(data.retake)")
//                }
//                print("success")
//            break
//            case .failure(let error) :
//                print(error)
//            break
//
//            }
//
//        }
        Crawler.shared.time_table_crawl(semester: nil)
    }
    
    
    
    
    
    private func configure()
    {
        tableView.dataSource = self
        tableView.rowHeight = 70
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

extension KnuNoticeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notice_knu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KnuNoticeCell.identifier, for: indexPath) as! KnuNoticeCell
        cell.notice_num.text = Notice_knu?[indexPath.row].num ?? ""
        cell.notice_title.text = Notice_knu?[indexPath.row].title ?? ""
        return cell
    }
}

