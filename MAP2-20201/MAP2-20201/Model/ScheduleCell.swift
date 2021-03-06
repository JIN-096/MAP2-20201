//
//  ScheduleCell.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/05/31.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCell : UITableViewCell{
    static let identifier = "ScheduleCell"
    
    let month_day : UILabel = {
       let month_day = UILabel()
        month_day.translatesAutoresizingMaskIntoConstraints = false
        month_day.textAlignment = .center
        month_day.numberOfLines = 0
        month_day.sizeToFit()
        
        return month_day
    }()


    let content : UILabel = {
       let content = UILabel()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.textAlignment = .left
        content.numberOfLines = 0
        content.sizeToFit()

        return content
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    private func addContentView(){
        contentView.addSubview(month_day)
        contentView.addSubview(content)
    }
    
    private func autoLayout(){
        let margin: CGFloat = 5
        NSLayoutConstraint.activate([
        month_day.topAnchor.constraint(equalTo: self.topAnchor),
        month_day.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        month_day.widthAnchor.constraint(equalToConstant: 100),
        month_day.heightAnchor.constraint(equalToConstant: 45),
        
        content.topAnchor.constraint(equalTo: self.topAnchor),
        content.leadingAnchor.constraint(equalTo: month_day.trailingAnchor, constant: margin),
        content.widthAnchor.constraint(equalToConstant: 100),
        content.heightAnchor.constraint(equalToConstant: 45),
        content.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

