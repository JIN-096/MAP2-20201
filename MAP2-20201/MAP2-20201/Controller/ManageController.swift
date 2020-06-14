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
    var necessaryList : [Necessary] = [Necessary]()
    var designList : [Necessary] = [Necessary]()
    var totalcondition : [TotalCondition] = [TotalCondition]()

    var total_count = 0
    var type1 = 0 // 기본소양
    var type2 = 0 // 전공기반
    var type3 = 0 // 공학전공
    var type4 = 0 // 공학인증
    var type5 = 0 // 설계과목
    var type6 = 0 // 필수과목
    
    
    // 섹션 항목
    private let sections: [String] = ["졸업 요건 달성 현황", "필수 과목 이수 현황","설계 과목 이수 현황"]
    
    // 필수과목 항목
    var necessaryList2 : [String] = ["자료구조","프로그래밍기초","기초프로그래밍","운영체제","시스템프로그래밍","종합설계프로젝트2","종합설계프로젝트1","컴퓨터구조","물리학 I","기초창의공학설계","기초공학물리학실험","물리학실험 I","자바프로그래밍","수학 I","이산수학","알고리즘1"]
    
    // 설계과목 항목
    var designList2 : [String] = ["시스템프로그래밍","디지털설계및실험","종합설계프로젝트1","종합설계프로젝트2","소프트웨어설계","소프트웨어공학","기초창의공학설계","자바프로그래밍"]
    
    
    @IBOutlet weak var managetableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = ActivityIndicator(view: view, navigationController: nil, tabBarController: nil)
        activityIndicator.showActivityIndicator(text: "로딩 중")
        managetableview.dataSource = self
        managetableview.delegate = self
        
        Crawler.shared.grade_crawl(category: 0){ result in
            switch result {
            case .success(let grade) :
                self.gradeList = grade
                print("manage success")
                
                
                for item in self.gradeList!{
                    // 필수과목 이수여부 O
                    if self.necessaryList2.contains(item.name){
                        self.necessaryList.append(Necessary(name: item.name, take: "O"))
                        let index = self.necessaryList2.firstIndex(of: item.name)
                        self.necessaryList2.remove(at: index!)
                        self.type6+=1
                    }
                    // 설계과목 이수여부 O
                    if self.designList2.contains(item.name){
                        self.designList.append(Necessary(name: item.name, take: "O"))
                        let index = self.designList2.firstIndex(of: item.name)
                        self.designList2.remove(at: index!)
                        if item.name == "종합설계프로젝트1" || item.name == "종합설계프로젝트2"{
                            self.type5+=4
                        }
                        else{
                            self.type5+=2
                        }
                    }
                    
                    switch item.type {
                    case "기본소양":
                        self.type1+=item.grade_unit
                        self.type4+=item.grade_unit
                        break
                    case "전공기반":
                        self.type2+=item.grade_unit
                        self.type4+=item.grade_unit
                        break
                    case "공학전공":
                        self.type3+=item.grade_unit
                        self.type4+=item.grade_unit
                        break
                
                    default: break
                    
                    }
                    self.total_count+=item.grade_unit
                }
                
                // 필수과목 이수여부 X
                for item in self.necessaryList2{
                    self.necessaryList.append(Necessary(name: item, take: "X"))
                }
                
                // 설계과목 이수여부 X
                for item in self.designList2{
                    self.designList.append(Necessary(name: item, take: "X"))
                }
                
                self.totalcondition.append(TotalCondition(type: "이수학점", condition: String(self.total_count)+" / 150 학점"))
                self.totalcondition.append(TotalCondition(type: "기본소양", condition: String(self.type1)+" / 15 학점"))
                self.totalcondition.append(TotalCondition(type: "전공기반", condition: String(self.type2)+" / 22 학점"))
                self.totalcondition.append(TotalCondition(type: "공학전공", condition: String(self.type3)+" / 75 학점"))
                self.totalcondition.append(TotalCondition(type: "공학인증", condition: String(self.type4)+" / 112 학점"))
                self.totalcondition.append(TotalCondition(type: "설계학점", condition: String(self.type5)+" / 16 학점"))
                self.totalcondition.append(TotalCondition(type: "필수과목", condition: String(self.type6)+" / 14 과목"))
                self.managetableview.reloadData()
                activityIndicator.stopActivityIndicator()
                break
            case .failure(let error) :
                print(error)
                break
            }
        }
        
        configure()
        autoLayout()
        managetableview.tableFooterView = UIView()
        
        
    }
    
    private func configure()
    {
        managetableview.translatesAutoresizingMaskIntoConstraints = false
        managetableview.register(ManageCell.self, forCellReuseIdentifier: ManageCell.identifier)
        managetableview.register(TotalConditionCell.self, forCellReuseIdentifier: TotalConditionCell.identifier)
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

extension ManageController : UITableViewDataSource, UITableViewDelegate{
    
    // Returns the number of sections.
    func numberOfSections(in tableView: UITableView) -> Int { return sections.count }

    // Returns the title of the section.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
//    // Called when Cell is selected.
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        if indexPath.section == 0
//        {
//            print(totalcondition[indexPath.row])
//        }
//        else if indexPath.section == 1
//        {
//            print(necessaryList[indexPath.row])
//        }
//        else if indexPath.section == 2
//        {
//            print(designList[indexPath.row])
//        }
//        else
//        {
//            return
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return totalcondition.count
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
        //let cell = managetableview.dequeueReusableCell(withIdentifier: ManageCell.identifier, for: indexPath) as! ManageCell
        //let cell2 = managetableview.dequeueReusableCell(withIdentifier: TotalConditionCell.identifier, for: indexPath) as! TotalConditionCell
        
        if indexPath.section == 0 {
            let cell2 = managetableview.dequeueReusableCell(withIdentifier: TotalConditionCell.identifier, for: indexPath) as! TotalConditionCell
//            cell2.subject_type.text = totalcondition[indexPath.row].type
//            cell2.condition.text = totalcondition[indexPath.row].condition
            cell2.subject_type.text = totalcondition[indexPath.row].type
            cell2.condition.text = totalcondition[indexPath.row].condition
            
            return cell2
        }
        else if indexPath.section == 1 {
             let cell = managetableview.dequeueReusableCell(withIdentifier: ManageCell.identifier, for: indexPath) as! ManageCell
            cell.subject_name.text = necessaryList[indexPath.row].name
            cell.take_bool.text = necessaryList[indexPath.row].take
            
            return cell
        }
        else if indexPath.section == 2{
             let cell = managetableview.dequeueReusableCell(withIdentifier: ManageCell.identifier, for: indexPath) as! ManageCell
            cell.subject_name.text = designList[indexPath.row].name
            cell.take_bool.text = designList[indexPath.row].take
            
            return cell
        }
        else
        {
            return UITableViewCell()
        }
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
