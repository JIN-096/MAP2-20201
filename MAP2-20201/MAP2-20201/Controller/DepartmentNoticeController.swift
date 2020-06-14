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
        departmentTableView.tableFooterView = UIView()
    }
    
    private func configure(){
        departmentTableView.translatesAutoresizingMaskIntoConstraints = false
        departmentTableView.register(TabelViewCellDepartment.self, forCellReuseIdentifier: TabelViewCellDepartment.identifier)
        departmentTableView.dataSource = self
        departmentTableView.delegate = self
        departmentTableView.estimatedRowHeight = 50
        departmentTableView.rowHeight = UITableView.automaticDimension
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
extension DepartmnetNoticeController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeDepartmnet?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = departmentTableView.dequeueReusableCell(withIdentifier: TabelViewCellDepartment.identifier, for: indexPath) as! TabelViewCellDepartment
        cell.notice_num.text = noticeDepartmnet?[indexPath.row].num ?? ""
        cell.notice_title.text = noticeDepartmnet?[indexPath.row].title ?? ""
//        if(cell.isSelected){
//            print("Row: \(indexPath.row)")
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("Row: \(indexPath.row)")
        var webViewController = WebViewController()
        var baseURL : String = "http://computer.knu.ac.kr/06_sub/02_sub.html"
        baseURL += noticeDepartmnet?[indexPath.row].ref ?? ""
        print(baseURL)
        webViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        webViewController.myURLString = baseURL
        self.navigationController?.pushViewController(webViewController, animated: true)


        
            
        
    }
}


