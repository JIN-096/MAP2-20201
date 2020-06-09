//
//  GradeCell.swift
//  MAP2-20201
//
//  Created by semin on 2020/06/02.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import UIKit

class GradeCell : UITableViewCell{
    static let identifier = "GradeCell"
    let subject_name : UILabel = {
        let subject_name = UILabel()
        subject_name.translatesAutoresizingMaskIntoConstraints = false
        subject_name.sizeToFit()
        subject_name.numberOfLines = 0
        return subject_name
    }()//과목이름
    let subject_type : UILabel = {
        let subject_type = UILabel()
        subject_type.translatesAutoresizingMaskIntoConstraints = false
        subject_type.sizeToFit()
        subject_type.numberOfLines = 0
        return subject_type
    }()//교양
    let subject_unit : UILabel = {
        let subject_unit = UILabel()
        subject_unit.translatesAutoresizingMaskIntoConstraints = false
        subject_unit.sizeToFit()
        subject_unit.numberOfLines = 0
        return subject_unit
    }()//학점
    let subject_semester : UILabel = {
        let subject_semester = UILabel()
        subject_semester.translatesAutoresizingMaskIntoConstraints = false
        subject_semester.sizeToFit()
        subject_semester.numberOfLines = 0
        return subject_semester
    }()
    let subject_rating : UILabel = {
        let subject_rating = UILabel()
        subject_rating.translatesAutoresizingMaskIntoConstraints = false
        subject_rating.sizeToFit()
        subject_rating.numberOfLines = 0
        return subject_rating
    }()//성적
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           addContentView()
           autoLayout()
       }
    
    private func addContentView(){
        contentView.addSubview(subject_semester)
        contentView.addSubview(subject_name)
        contentView.addSubview(subject_type)
        contentView.addSubview(subject_unit)
        contentView.addSubview(subject_rating)
    }
    
    private func autoLayout(){
        let margin: CGFloat = 5
        NSLayoutConstraint.activate([
        subject_semester.topAnchor.constraint(equalTo: self.topAnchor),
        subject_semester.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        subject_semester.widthAnchor.constraint(equalToConstant: 70),
        subject_semester.heightAnchor.constraint(equalToConstant: 50),
        
        subject_name.topAnchor.constraint(equalTo: self.topAnchor),
        subject_name.leadingAnchor.constraint(equalTo: subject_semester.trailingAnchor, constant: margin),
        subject_name.widthAnchor.constraint(equalToConstant: 100),
        subject_name.heightAnchor.constraint(equalToConstant: 50),
//        subject_name.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
        subject_type.topAnchor.constraint(equalTo: self.topAnchor),
        subject_type.leadingAnchor.constraint(equalTo: subject_name.trailingAnchor, constant: margin),
        subject_type.widthAnchor.constraint(equalToConstant: 80),
        subject_type.heightAnchor.constraint(equalToConstant: 50),
//        subject_type.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
        subject_unit.topAnchor.constraint(equalTo: self.topAnchor),
        subject_unit.leadingAnchor.constraint(equalTo: subject_type.trailingAnchor, constant: margin),
        subject_unit.widthAnchor.constraint(equalToConstant: 50),
        subject_unit.heightAnchor.constraint(equalToConstant: 50),
//        subject_unit.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
        subject_rating.topAnchor.constraint(equalTo: self.topAnchor),
        subject_rating.leadingAnchor.constraint(equalTo: subject_unit.trailingAnchor, constant: margin),
        subject_rating.widthAnchor.constraint(equalToConstant: 50),
        subject_rating.heightAnchor.constraint(equalToConstant: 50),
        subject_rating.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
        
        
        
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
