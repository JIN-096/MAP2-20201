//
//  MileageCell.swift
//  MAP2-20201
//
//  Created by 천지완 on 2020/06/14.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class MileageCell : UITableViewCell{
    static let identifier = "MileageCell"
    let mileage_name : UILabel = {
       let mileage_name = UILabel()
        mileage_name.translatesAutoresizingMaskIntoConstraints = false
        mileage_name.sizeToFit()
        mileage_name.numberOfLines = 0
        mileage_name.textAlignment = .left
        return mileage_name
    }()
    
//    let mileage_day : UILabel = {
//        let mileage_day = UILabel()
//        mileage_day.translatesAutoresizingMaskIntoConstraints = false
//        mileage_day.sizeToFit()
//        mileage_day.numberOfLines = 0
//
//        return mileage_day
//    }()
    
    let mileage_num : UILabel = {
        let mileage_num = UILabel()
        mileage_num.translatesAutoresizingMaskIntoConstraints = false
        mileage_num.sizeToFit()
        mileage_num.numberOfLines = 0
        mileage_num.textAlignment = .center
        return mileage_num
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()
    }
    
    private func addContentView(){
        contentView.addSubview(mileage_name)
//        contentView.addSubview(mileage_day)
        contentView.addSubview(mileage_num)
    }
    
    private func autoLayout(){
        let margin: CGFloat = 5
        NSLayoutConstraint.activate([
                mileage_name.topAnchor.constraint(equalTo: self.topAnchor),
                mileage_name.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                mileage_name.widthAnchor.constraint(equalToConstant: 80),
                mileage_name.heightAnchor.constraint(equalToConstant: 50),
                
//                mileage_day.topAnchor.constraint(equalTo: self.topAnchor),
//                mileage_day.leadingAnchor.constraint(equalTo: mileage_name.trailingAnchor, constant: margin),
//                mileage_day.widthAnchor.constraint(equalToConstant: 40),
//                mileage_day.heightAnchor.constraint(equalToConstant: 50),
                
                mileage_num.topAnchor.constraint(equalTo: self.topAnchor),
                mileage_num.leadingAnchor.constraint(equalTo: mileage_name.trailingAnchor, constant: margin),
                mileage_num.widthAnchor.constraint(equalToConstant: 40),
                mileage_num.heightAnchor.constraint(equalToConstant: 50),
                mileage_num.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
