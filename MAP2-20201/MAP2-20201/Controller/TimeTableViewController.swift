//
//  TimeTableViewController.swift
//  MAP2-20201
//
//  Created by pcrmcw0486 on 2020/06/08.
//  Copyright © 2020 COMP420. All rights reserved.
//

import UIKit
import Elliotable

class TimeTableViewController: UIViewController, ElliotableDelegate, ElliotableDataSource{
  
    @IBOutlet weak var elliotable: Elliotable!
    private let daySymbol = ["월", "화", "수", "목", "금", "토"]
    var timeTable : [Timetable]?
    var myCourses : [(Code : String, sub : String)]?
    
    override func viewDidLoad() {
        //  수강하고 있는 정보 가져오기
        let activityIndicator = ActivityIndicator(view: view, navigationController: nil, tabBarController: nil)
        activityIndicator.showActivityIndicator(text: "로딩 중")
                Crawler.shared.time_table_crawl(semester: nil){ result in
                    switch result{
        
                    case .success(let mycourse):
                        self.myCourses = mycourse
                        for data in self.myCourses!{
                            print(data.Code, data.sub)
                        }
                        self.timeTable = Crawler.shared.time_table_data_crawl(semester: "20201", Codes: self.myCourses!)
//                        if self.timeTable != nil{
//                            for course in self.timeTable!{
//                                print(course.courseName)
//                                for time in course.courseTimes{
//                                    print(time.courseDay, terminator: " ")
//                                    print(time.startTime, terminator: " ")
//                                    print(time.endTime)
//                                }
//                                print("-----------------------------")
//                            }
//                        }
                        self.elliotable.reloadData()
                        activityIndicator.stopActivityIndicator()
                    case .failure(let error):
                        print(error)
                    }
                }
        elliotable.delegate = self
        elliotable.dataSource = self

        // Do any additional setup after loading the view.
    }
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        var baseURL : String = ""
        let checkId = selectedCourse.courseId
        for time in timeTable!{
            if checkId == time.courseId{
                baseURL = time.course_url
                print(baseURL)
                break
            }
        }
        
        var webViewController = WebViewController()
        
        webViewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        webViewController.myURLString = baseURL
        webViewController.modalTransitionStyle = .coverVertical
        self.present(webViewController, animated: true, completion: nil)
        
    }
      
      func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
      }
      
      func elliotable(elliotable: Elliotable, at dayPerIndex: Int) -> String {
        return self.daySymbol[dayPerIndex]
      }
      
      func numberOfDays(in elliotable: Elliotable) -> Int {
        return self.daySymbol.count
      }
      
      func courseItems(in elliotable: Elliotable) -> [ElliottEvent] {
        var courselist = [ElliottEvent]()
        
      //  let course_2 = ElliottEvent(courseId: "c0002", courseName: "Operating System", roomName: "IT Building 21204", professor: "TEST", courseDay: .thursday, startTime: "12:00", endTime: "13:15", textColor: UIColor.white, backgroundColor: #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1))
       // courselist.append(course_2)
        if timeTable != nil{
            for course in timeTable!{
                print(course.courseName)
                let color : UIColor = getRandomColor()
                for time in course.courseTimes{
                    print(time.courseDay, terminator: " ")
                    print(time.startTime, terminator: " ")
                    print(time.endTime)
                    
                    let dayType : ElliotDay
                    switch time.courseDay {
                    case "월" :
                        dayType = ElliotDay.monday
                        break
                    case "화" :
                        dayType = ElliotDay.tuesday
                        break
                    case "수" :
                        dayType = ElliotDay.wednesday
                        break
                    case "목" :
                        dayType = ElliotDay.thursday
                        break
                    case "금" :
                        dayType = ElliotDay.friday
                        break
                    case "토" :
                        dayType = ElliotDay.saturday
                        break
                    default:
                        dayType = ElliotDay.monday
                        break
                    }
                    
                    let course = ElliottEvent(courseId: course.courseId, courseName: course.courseName, roomName: course.roomName, professor: course.professor, courseDay: dayType, startTime: time.startTime, endTime: time.endTime, backgroundColor: color)
                    courselist.append(course)
                }
                print("-----------------------------")
            }
            print("!")
        }
        print("@")
        return courselist
      }
      
     func getRandomColor() -> UIColor{
            
            let randomRed:CGFloat = CGFloat(drand48())
            
            let randomGreen:CGFloat = CGFloat(drand48())
            
            let randomBlue:CGFloat = CGFloat(drand48())
            
            return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
            
        }

}
