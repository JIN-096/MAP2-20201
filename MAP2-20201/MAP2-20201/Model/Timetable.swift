//
//  Timetable.swift
//  MAP2-20201
//
//  Created by pcrmcw0486 on 2020/06/08.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation

struct Timetable
{
    var courseId : String
    var courseName : String
    var professor : String
    var roomName : String
    var courseTimes : [CourseTime] = []
}
struct CourseTime
{
    var courseDay : String
    var startTime : String
    var endTime : String
}

//func TimeFormatChange(unformattd_time : String)-> String{
//    switch unformattd_time {
//    case "0A":
//        return ""
//        break
//    case "0B" :
//        return ""
//        break
//    default:
//    }
//}
