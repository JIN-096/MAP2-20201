//
//  TableViewController.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/04/29.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class TableViewController : UIViewController{
    
    var Notice_knu : [Notice]? = Crawler.shared.knu_notice_crawl(URL: nil)
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell_1.self, forCellReuseIdentifier: TableViewCell_1.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addSubView()
        autoLayout()
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

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notice_knu?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell_1.identifier, for: indexPath) as! TableViewCell_1
        cell.notice_num.text = Notice_knu?[indexPath.row].num ?? ""
        cell.notice_title.text = Notice_knu?[indexPath.row].title ?? ""
        return cell
    }
}