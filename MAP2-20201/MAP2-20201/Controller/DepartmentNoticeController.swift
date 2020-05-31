//
//  DepartmentNoticeController.swift
//  MAP2-20201
//
//  Created by semin on 2020/05/31.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit


class DepartmnetNoticeController : UIViewController{
    
    var noticeDepartmnet : [Notice]? = Crawler.shared.computer_total_notice_crawl(URL: nil)
   
    @IBOutlet weak var departmentTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        autoLayout()
        
    }
    
    private func configure(){
        departmentTableView.translatesAutoresizingMaskIntoConstraints = false
        departmentTableView.register(TabelViewCellDepartment.self, forCellReuseIdentifier: TabelViewCellDepartment.identifier)
        departmentTableView.dataSource = self
        departmentTableView.rowHeight = 40
    }
    
    private func autoLayout(){
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            departmentTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            departmentTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            departmentTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            departmentTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
    }
}
extension DepartmnetNoticeController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeDepartmnet?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = departmentTableView.dequeueReusableCell(withIdentifier: TabelViewCellDepartment.identifier, for: indexPath) as! TabelViewCellDepartment
        cell.notice_num.text = noticeDepartmnet?[indexPath.row].num ?? ""
        cell.notice_title.text = noticeDepartmnet?[indexPath.row].title ?? ""
        return cell
    }
}


