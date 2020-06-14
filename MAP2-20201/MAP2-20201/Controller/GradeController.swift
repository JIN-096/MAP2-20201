//
//  GradeController.swift
//  MAP2-20201
//
//  Created by semin on 2020/06/02.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit
    
import Swift



class GradeController : UIViewController{
    
    var gradeList : [Grade]?
       


    @IBOutlet weak var gradeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = ActivityIndicator(view: view, navigationController: nil, tabBarController: nil)
        activityIndicator.showActivityIndicator(text: "로딩 중")
        configure()
        autoLayout()
        gradeTableView.tableFooterView = UIView()
        Crawler.shared.grade_crawl(category: 0){ result in
            switch result {
            case .success(let grade) :
                self.gradeList = grade
//                for data in self.gradeList!{
//                    print("\(data.code) \(data.open_department) \(data.name) \(data.type) \(data.grade_unit) \(data.semester) \(data.rating) \(data.retake)")
//                }
                print("success")
                self.gradeTableView.reloadData()
                activityIndicator.stopActivityIndicator()
                break
            case .failure(let error) :
                print(error)
                break
            }
        }
        
        
        
    }
    
    private func configure(){
        gradeTableView.translatesAutoresizingMaskIntoConstraints = false
        gradeTableView.register(GradeCell.self, forCellReuseIdentifier: GradeCell.identifier)
        gradeTableView.dataSource = self
        gradeTableView.estimatedRowHeight = 50
        gradeTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func autoLayout(){
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            gradeTableView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            gradeTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            gradeTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            gradeTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
    }
}
extension GradeController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradeList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gradeTableView.dequeueReusableCell(withIdentifier: GradeCell.identifier, for: indexPath) as! GradeCell
        cell.subject_semester.text = gradeList?[indexPath.row].semester ?? ""
        
        cell.subject_name.text = gradeList?[indexPath.row].name ?? ""
        
        cell.subject_type.text = gradeList?[indexPath.row].type ?? ""
        
        let text : Int? = gradeList?[indexPath.row].grade_unit
        cell.subject_unit.text = String(text!)
        
        
        cell.subject_rating.text = gradeList?[indexPath.row].rating ?? ""
        return cell
    }
}
