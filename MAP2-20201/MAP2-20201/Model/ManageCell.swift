//
//  ManageCell.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/06/09.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class ManageCell : UITableViewCell
{
    static let identifier = "ManageCell"
    let subject_name : UILabel = {
       let subject_name = UILabel()
        subject_name.translatesAutoresizingMaskIntoConstraints = false
        subject_name.sizeToFit()
        subject_name.numberOfLines = 0
        
        return subject_name
    }() // 교과목명
    
    let take_bool : UILabel = {
       let take_bool = UILabel()
        take_bool.translatesAutoresizingMaskIntoConstraints = false
        take_bool.sizeToFit()
        take_bool.numberOfLines = 0
        
        return take_bool
    }() // 이수여부
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    
    private func addContentView(){
        contentView.addSubview(subject_name)
        contentView.addSubview(take_bool)
    }
    
    private func autoLayout()
    {
        let margin: CGFloat = 5
        NSLayoutConstraint.activate([
            subject_name.topAnchor.constraint(equalTo: self.topAnchor),
            subject_name.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subject_name.widthAnchor.constraint(equalToConstant: 70),
            subject_name.heightAnchor.constraint(equalToConstant: 50),
            
            take_bool.topAnchor.constraint(equalTo: self.topAnchor),
            take_bool.leadingAnchor.constraint(equalTo: subject_name.trailingAnchor, constant: margin),
            take_bool.widthAnchor.constraint(equalToConstant: 50),
            take_bool.heightAnchor.constraint(equalToConstant: 50),
            take_bool.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
