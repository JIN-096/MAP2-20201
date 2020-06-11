//
//  TotalConditionCell.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/06/10.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class TotalConditionCell : UITableViewCell
{
    static let identifier = "TotalConditionCell"
    
    let subject_type : UILabel = {
       let subject_type = UILabel()
        subject_type.translatesAutoresizingMaskIntoConstraints = false
        subject_type.sizeToFit()
        subject_type.numberOfLines = 0
        
        return subject_type
    }() // 과목 구분
    
    let condition : UILabel = {
        let condition = UILabel()
        condition.translatesAutoresizingMaskIntoConstraints = false
        condition.sizeToFit()
        condition.numberOfLines = 0
        condition.textAlignment = .center
        
        return condition
    }() // 이수현황 및 조건
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    private func addContentView(){
        contentView.addSubview(subject_type)
        contentView.addSubview(condition)
    }
    
    private func autoLayout()
    {
        let margin: CGFloat = 5
        NSLayoutConstraint.activate([
            subject_type.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            subject_type.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
//            subject_type.widthAnchor.constraint(equalToConstant: 70),
//            subject_type.heightAnchor.constraint(equalToConstant: 50),
            
            condition.topAnchor.constraint(equalTo: self.topAnchor),
//            condition.leadingAnchor.constraint(equalTo: subject_type.trailingAnchor, constant: 50),
            condition.widthAnchor.constraint(equalToConstant: 150),
            condition.heightAnchor.constraint(equalToConstant: 50),
            condition.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
