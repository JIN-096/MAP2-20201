//
//  ScheduleController.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/05/31.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class ScheduleController : UIViewController{
    
    var calendars : [Calendar]? = Crawler.shared.academic_calendar_crawl()
    
//    private let tableView : UITableView = {
//       let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.identifier)
//        return tableView
//    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
//        addSubView()
        //autoLayout()
    }
    
    private func configure()
    {
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = 40
    }
    
//    private func addSubView()
//    {
//        view.addSubview(tableView)
//    }
    
    private func autoLayout()
    {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: guide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
}

extension ScheduleController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendars?[3].schedules.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.identifier, for: indexPath) as! ScheduleCell
       
        
        cell.month_day.text = calendars?[3].schedules[indexPath.row].day ?? ""
        cell.content.text = calendars?[3].schedules[indexPath.row].content ?? ""
       
       return cell
        
    }
    
   
    
   
}
