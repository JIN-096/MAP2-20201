//
//  Grade.swift
//  MAP2-20201
//
//  Created by pcrmcw0486 on 2020/04/28.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation


struct Grade
{
    let code : String
    let open_department : String
    let name : String // 과목이름
    let type : String // 과목구분
    //일단 구조체 이름이랑 다르게 설정하겟음
    let grade_unit : Int  //학점
    let semester : String //학기
    let rating : String // 성적
    let retake : Bool 
}
