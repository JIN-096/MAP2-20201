//
//  Computer_Bachelor.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/05/31.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class ComputerMajorNoticeController : UIViewController{
    
    var Notice_knu : [Notice]? = Crawler.shared.computer_major_notice_crawl(URL: nil)
    
    private let tableView : UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ComputerMajorCell.self, forCellReuseIdentifier: ComputerMajorCell.identifier)
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
        tableView.tableFooterView = UIView()
        

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

extension ComputerMajorNoticeController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notice_knu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComputerMajorCell.identifier, for: indexPath) as! ComputerMajorCell
        cell.notice_num.text = Notice_knu?[indexPath.row].num ?? ""
        cell.notice_title.text = Notice_knu?[indexPath.row].title ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        var webViewController = WebViewController()
        var baseURL : String = "http://computer.knu.ac.kr/06_sub/02_sub_2.html"
        baseURL += Notice_knu?[indexPath.row].ref ?? ""
        print(baseURL)
        webViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        webViewController.myURLString = baseURL
        self.navigationController?.pushViewController(webViewController, animated: true)


        
            
        
    }
    
}
