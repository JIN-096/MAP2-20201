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
    var month = 1
    
//    private let tableView : UITableView = {
//       let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.identifier)
//        return tableView
//    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var Show_Year: UILabel!
    
    @IBOutlet weak var Show_Month: UILabel!
    
    @IBAction func Next_month(_ sender: Any) {
        if(month+1==13)
        {
            month=1
        }
        else{
            month+=1
        }
        Show_Month.text=String(month)+"월"
        self.tableView.reloadData()
    }
    @IBAction func Before_month(_ sender: Any) {
        if(month-1==0)
        {
            month=12
        }
        else{
            month-=1
        }
        Show_Month.text=String(month)+"월"
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        Show_Year.text="2020년"
        Show_Month.text="1월"
        Show_Year.textColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        Show_Month.textColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        tableView.tableFooterView = UIView() // 밑에 구분선 안나오게
    //        addSubView()
            //autoLayout()
    }
    private func configure()
    {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //앞에 구분선 잘리는거 없애기
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.separatorInset.left = 0
        
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.identifier)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
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
        return calendars?[month-1].schedules.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.identifier, for: indexPath) as! ScheduleCell
       
        
        cell.month_day.text = calendars?[month-1].schedules[indexPath.row].day ?? ""
        cell.content.text = calendars?[month-1].schedules[indexPath.row].content ?? "g"
        cell.separatorInset = UIEdgeInsets.zero
        
    
       return cell
        
    }

   
}
