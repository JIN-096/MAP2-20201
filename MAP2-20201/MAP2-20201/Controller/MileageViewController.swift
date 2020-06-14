//
//  MileageViewController.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/06/14.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class MileageViewController : UIViewController{
    
    var mileageList : [Mileage]?
    
    
   
    @IBOutlet weak var mileagetableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = ActivityIndicator(view: view, navigationController: nil, tabBarController: nil)
        activityIndicator.showActivityIndicator(text: "로딩 중")
        
        configure()
        autoLayout()
        mileagetableview.tableFooterView = UIView()
        Crawler.shared.mileage_crawl{ result in
            switch result {
            case .success(let mileage):
                print(mileage)
                self.mileageList = mileage
                
                for data in self.mileageList!{
                    print("\(data.description) \(data.date) \(data.mileage)")
                }
                print("success")
                self.mileagetableview.reloadData()
                activityIndicator.stopActivityIndicator()
                break
            case.failure(let error):
                print(error)
                break
            }
            
        }
    }
    
    private func configure()
    {
        mileagetableview.translatesAutoresizingMaskIntoConstraints = false
        mileagetableview.register(MileageCell.self, forCellReuseIdentifier: MileageCell.identifier)
        mileagetableview.dataSource = self
        mileagetableview.delegate = self
        mileagetableview.estimatedRowHeight = 50
        mileagetableview.rowHeight = UITableView.automaticDimension
    }
    private func autoLayout(){
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mileagetableview.topAnchor.constraint(equalTo: guide.topAnchor),
            mileagetableview.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mileagetableview.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mileagetableview.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
    }
    
}

extension MileageViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mileageList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mileagetableview.dequeueReusableCell(withIdentifier: MileageCell.identifier, for: indexPath) as! MileageCell
        
        cell.mileage_name.text = mileageList?[indexPath.row].description ?? ""
        
        cell.mileage_num.text = mileageList?[indexPath.row].mileage ?? ""
        
        return cell
        
    }
}
