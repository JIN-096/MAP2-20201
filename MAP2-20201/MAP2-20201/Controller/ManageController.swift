//
//  ManageController.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/06/09.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class ManageController : UIViewController
{
    var gradeList : [Grade]?
    
    private let sections: [String] = ["졸업 요건 달성 현황", "필수 과목 이수 현황","설계 과목 이수 현황"]
    var necessaryList : [Necessary] = [Necessary]()
    var designList : [Necessary] = [Necessary]()

    var designList2 : [String] = ["시스템프로그래밍","디지털설계및실험","종합설계프로젝트1","종합설계프로젝트2","소프트웨어설계","소프트웨어공학","기초창의공학설계","자바프로그래밍"]
    
    var necessaryList2 : [String] = ["자료구조","프로그래밍기초","운영체제","시스템프로그래밍","종합설계프로젝트2","종합설계프로젝트1","컴퓨터구조","물리학 I","기초창의공학설계","기초공학물리학실험","물리학실험 I","자바프로그래밍","수학 I","이산수학","알고리즘1"]
    
    @IBOutlet weak var managetableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Crawler.shared.grade_crawl(category: 0){ result in
            switch result {
            case .success(let grade) :
                self.gradeList = grade
                print("manage success")
                for item in self.gradeList!{
                    if self.necessaryList2.contains(item.name){
                        self.necessaryList.append(Necessary(name: item.name, take: "O"))
                        let index = self.necessaryList2.firstIndex(of: item.name)
                        self.necessaryList2.remove(at: index!)
                    }
                }
                for item in self.gradeList!{
                    if self.designList2.contains(item.name){
                        self.designList.append(Necessary(name: item.name, take: "O"))
                        let index = self.designList2.firstIndex(of: item.name)
                        self.designList2.remove(at: index!)
                    }
                    else{
                        
                    }
                }
                
                for item in self.necessaryList2{
                
                    self.necessaryList.append(Necessary(name: item, take: "X"))
                }
                
                for item in self.designList2{
                    self.designList.append(Necessary(name: item, take: "X"))
                }
                
                self.managetableview.reloadData()
                break
            case .failure(let error) :
                print(error)
                break
            }
        }
        
        configure()
        autoLayout()
        //setNecessaryList()
        //setDesginList()
        managetableview.tableFooterView = UIView()
        
        
    }
    
    
    private func setDesginList()
    {
        designList.append(Necessary(name: "시스템프로그래밍", take: "X"))
        designList.append(Necessary(name: "디지털설계및실험", take: "X"))
        designList.append(Necessary(name: "종합설계프로젝트1", take: "X"))
        designList.append(Necessary(name: "종합설계프로젝트2", take: "X"))
        designList.append(Necessary(name: "소프트웨어설계", take: "X"))
        designList.append(Necessary(name: "소프트웨어공학", take: "X"))
        designList.append(Necessary(name: "기초창의공학설계", take: "X"))
        designList.append(Necessary(name: "자바프로그래밍", take: "X"))
        
    }
    private func setNecessaryList()
    {
        necessaryList.append(Necessary(name: "자료구조", take: "X"))
        necessaryList.append(Necessary(name: "프로그래밍기초", take: "X"))
        necessaryList.append(Necessary(name: "기초프로그래밍", take: "X"))
        necessaryList.append(Necessary(name: "운영체제", take: "X"))
        necessaryList.append(Necessary(name: "시스템프로그래밍", take: "X"))
        necessaryList.append(Necessary(name: "종합설계프로젝트2", take: "X"))
        necessaryList.append(Necessary(name: "종합설계프로젝트1", take: "X"))
        necessaryList.append(Necessary(name: "컴퓨터구조", take: "X"))
        necessaryList.append(Necessary(name: "물리학 I", take: "X"))
        necessaryList.append(Necessary(name: "기초창의공학설계", take: "X"))
        necessaryList.append(Necessary(name: "기초공학물리학실험", take: "X"))
        necessaryList.append(Necessary(name: "물리학실험 I", take: "X"))
        necessaryList.append(Necessary(name: "자바프로그래밍", take: "X"))
        necessaryList.append(Necessary(name: "수학 I", take: "X"))
        necessaryList.append(Necessary(name: "이산수학", take: "X"))
        necessaryList.append(Necessary(name: "알고리즘1", take: "X"))
        
    }
    
    private func configure()
    {
        managetableview.translatesAutoresizingMaskIntoConstraints = false
        managetableview.register(ManageCell.self, forCellReuseIdentifier: ManageCell.identifier)
        managetableview.dataSource = self
        managetableview.estimatedRowHeight = 50
        managetableview.rowHeight = UITableView.automaticDimension
    }
    
    private func autoLayout(){
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            managetableview.topAnchor.constraint(equalTo: guide.topAnchor),
            managetableview.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            managetableview.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            managetableview.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
    }
    
   
    
}

extension ManageController : UITableViewDataSource{
    
    // Returns the number of sections.
    func numberOfSections(in tableView: UITableView) -> Int { return sections.count }

    // Returns the title of the section.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    // Called when Cell is selected.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            
        }
        else if indexPath.section == 1
        {
            print(necessaryList[indexPath.row])
        }
        else if indexPath.section == 2
        {
            print(designList[indexPath.row])
        }
        else
        {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        else if section == 1{
            return necessaryList.count
        }
        else if section == 2{
            return designList.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = managetableview.dequeueReusableCell(withIdentifier: ManageCell.identifier, for: indexPath) as! ManageCell
        
        if indexPath.section == 0 {
            
        }
        else if indexPath.section == 1 {
            cell.subject_name.text = necessaryList[indexPath.row].name
            cell.take_bool.text = necessaryList[indexPath.row].take
        }
        else if indexPath.section == 2{
            cell.subject_name.text = designList[indexPath.row].name
            cell.take_bool.text = designList[indexPath.row].take
        }
        else
        {
            return UITableViewCell()
        }
        
        
        return cell
    }
    
    

}

//replace 함수를 사용할 수 있는 코드..

extension String {

    func replace(target: String, withString: String) -> String {

        return self.replacingOccurrences(of: target,

                                         with: withString,

                                         options: NSString.CompareOptions.literal,

                                         range: nil)

    }

}

extension Array where Element: Equatable {

    mutating func remove(_ element: Element) {
        _ = index(of: element).flatMap {
            self.remove(at: $0)
        }
    }
}
