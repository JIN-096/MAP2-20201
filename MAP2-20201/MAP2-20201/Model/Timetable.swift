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

//let index = time.startIndex
//let day = String(time[...index])
//let detailtime = String(time[index...]).getArrayAfterRegex(regex : "[0-9]{1,}[A|B]")
//let start = detailtime[detailtime.startIndex]
//let end = detailtime[detailtime.endIndex - 1]
func TimeFormatChange(unformatted_time : String, type : Int)-> String{
    var formatted_string = ""
    var hour = 0
    var minute = "00"
    let typeIndex = unformatted_time.index(before: unformatted_time.endIndex)
    let time_type = String(unformatted_time[typeIndex...])
    let time_num = String(unformatted_time[unformatted_time.startIndex..<typeIndex])
    print("get unfomatted_time : \(unformatted_time)")
    print("type : \(type)")
    print("잘린 스트링 A|B : \(time_type)")
    print("잘린 스트링 시간 : \(time_num)")
    //type 0은 startTime 1은 endTime
    if type == 0 {
        if time_num == "000"{
            hour = 8
        }
        else{
            hour = Int(time_num)! + 8
        }
        if time_type == "B"{
            minute = "30"
        }
    }
    else if type == 1{
        hour = Int(time_num)! + 8
        if time_type == "A"{
            minute = "30"
        }
        else if time_type == "B"{
            hour = hour + 1
        }
    }
    formatted_string = String(hour) + ":" + minute
    return formatted_string
}
