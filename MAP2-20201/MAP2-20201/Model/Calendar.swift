//
//  Calendar.swift
//  MAP2-20201
//
//  Created by pcrmcw0486 on 2020/04/28.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation

struct Calendar
{
    typealias Item = (day : String, content : String)
    var year : Int
    var month : Int
    var schedules : [Schedule] = []    
}
struct Schedule
{
    var day : String
    var content : String
}
