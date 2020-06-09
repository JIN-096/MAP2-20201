//
//  TableViewCell_1.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/04/29.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class KnuNoticeCell : UITableViewCell{
    
    static let identifier = "KnuNoticeCell"
    
    let notice_num : UILabel = {
        let notice_num = UILabel()
        notice_num.translatesAutoresizingMaskIntoConstraints = false
        notice_num.sizeToFit()
        notice_num.numberOfLines = 0
        return notice_num
    }()
    
    let notice_title : UILabel = {
        let notice_title = UILabel()
        notice_title.translatesAutoresizingMaskIntoConstraints = false
        notice_title.numberOfLines = 0
        notice_title.sizeToFit()
        return notice_title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    private func addContentView(){
        contentView.addSubview(notice_num)
        contentView.addSubview(notice_title)
    }
    
    private func autoLayout(){
        let margin: CGFloat = 5
        NSLayoutConstraint.activate([
        notice_num.topAnchor.constraint(equalTo: self.topAnchor),
        notice_num.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        notice_num.widthAnchor.constraint(equalToConstant: 50),
        notice_num.heightAnchor.constraint(equalToConstant: 50),
        
        notice_title.topAnchor.constraint(equalTo: self.topAnchor),
        notice_title.leadingAnchor.constraint(equalTo: notice_num.trailingAnchor, constant: margin),
        notice_title.widthAnchor.constraint(equalToConstant: 50),
        notice_title.heightAnchor.constraint(equalToConstant: 50),
        notice_title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
