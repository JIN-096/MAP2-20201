//
//  Crawler.swift
//  MAP2-20201
//
//  Created by pcrmcw0486 on 2020/04/21.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation
import SwiftSoup
import Alamofire

//crawler 싱글톤 객체로 생성하여 ~> 게터 세터가 필요한가? 천천히 생각해본다.
//싱글톤을 사용하는 이유는 메모리 낭비를 방지하고 데이터를 공유하는데 있다.
//싱글톤 객체 생성 방법 참조 링크
//http://throughkim.kr/2019/09/04/swift-singleton/
//https://linsaeng.tistory.com/9
//https://velog.io/@naroti/iOS-%EA%B0%9C%EB%B0%9C-Singleton-Pattern-q4k3uzgf0n
//이후 싱글톤 관련해서는 다시 코딩함. (04.27) ~> Crawler.swift && Person_info.swift
//04.27 중복되는 코드 및 모델링에 있어서 뭔가 마음에 안드는데 고쳐나갈예정.

class Crawler
{
    //typealias notice = Notice;
    //static 전역 변수로 선언하는데 이 프로퍼티는 지연생성(lazy)되기 때문에 처음 클래스를 생성하기까지는
    //메모리에 올라가지 않는다
    
    static let shared = Crawler()
    
    // private var url : String = ""
    
    //생성자를 private으로 제한해서 외부에서 인스턴스를 생성하지 못하도록 강제하여, 유니크한 싱글톤을 만든다.
    private init() {}
    
    //Download HTML
    func downloadHTML(input_URL : String) -> Document?{
        var document: Document = Document.init("")
        // url string to URL
        guard let url = URL(string: input_URL ) else {
            // an error occurred
            print("Error: \(input_URL) doesn't seem to be a valid URL")
            return nil
        }
        
        do {
            // content of url
            let html = try String.init(contentsOf: url)
            //html 문서 다운로드
            // print(html)
            // parse it into a Document
            //document 로 변환 일단 파싱함.
            document = try SwiftSoup.parse(html)
            // parse css query
            //주어진 css query 로 파싱함.
        } catch let error {
            // an error occurred
            print("Error: \(error)")
        }
        return document
    }
    
    //knu.ac.kr 본관 공지 크롤링
    func knu_notice_crawl(URL : String?) -> [Notice]?
    {
        var document : Document?
        let url = URL ?? "https://knu.ac.kr/wbbs/wbbs/bbs/btin/stdList.action?menu_idx=42"
        document = downloadHTML(input_URL: url) ?? nil
        if(document == nil){
            return nil
        }
        var notices = [Notice]()
        let selector = "tbody>tr"
        do {
            //여기서  element객체를 css selector를 통해 파싱해서 element에 넣어줌.
            let elements: Elements = try document!.select(selector )
            //transform it into a local object (Item)
            for element in elements {
                let num = try element.select(".num").text();
                let title = try element.select("a").text()
                let ref : String =  try element.select("a").attr("href")
                let writer = try element.select(".writer").text()
                let date = try element.select(".date").text()
                let hit = try element.select(".hit").text()
                let file = try element.select(".file").text().elementsEqual("")
                notices.append(Notice(num: num,title: title,ref: ref,wrtier: writer,date: date,hit: hit,file: file))
            }
            
        } catch let error {
            print("Error: \(error)")
        }
        return notices
    }
   
    
    //knu.ac.kr 본관 공지 크롤링 변경
       func knu_notice_crawl(page : Int?) -> [Notice]?
       {
           var document : Document?
           var url = "https://knu.ac.kr/wbbs/wbbs/bbs/btin/stdList.action?menu_idx=42"
            let target_page : String  = "&btin.page=" + String(page ?? 1)
                   url = url + target_page
           document = downloadHTML(input_URL: url) ?? nil
           if(document == nil){
               return nil
           }
           var notices = [Notice]()
           let selector = "tbody>tr"
           do {
               //여기서  element객체를 css selector를 통해 파싱해서 element에 넣어줌.
               let elements: Elements = try document!.select(selector )
               //transform it into a local object (Item)
               for element in elements {
                   let num = try element.select(".num").text();
                   let title = try element.select("a").text()
                   let ref : String =  try element.select("a").attr("href")
                   let writer = try element.select(".writer").text()
                   let date = try element.select(".date").text()
                   let hit = try element.select(".hit").text()
                   let file = try element.select(".file").text().elementsEqual("")
                   notices.append(Notice(num: num,title: title,ref: ref,wrtier: writer,date: date,hit: hit,file: file))
               }
               
           } catch let error {
               print("Error: \(error)")
           }
           return notices
       }
    //computer.knu.ac.kr 전체공지
    func computer_total_notice_crawl(URL : String?) -> [Notice]?
    {
        var document : Document?
        let url = URL ?? "http://computer.knu.ac.kr/06_sub/02_sub.html"
        document = downloadHTML(input_URL: url) ?? nil
        if(document == nil){
            return nil
        }
        var notices = [Notice]()
        let selector = "tbody>tr"
        do {
            //여기서  element객체를 css selector를 통해 파싱해서 element에 넣어줌.
            let elements: Elements = try document!.select(selector )
            //transform it into a local object (Item)
            for element in elements {
                let num = try element.select(".bbs_num").text();
                let title = try element.select("a").text()
                let ref : String =  try element.select("a").attr("href")
                let writer = try element.select(".bbs_writer").text()
                let date = try element.select(".bbs_date").text()
                let hit = try element.select(".bbs_hit").text()
                let file = false
                notices.append(Notice(num: num,title: title,ref: ref,wrtier: writer,date: date,hit: hit,file: file))
            }

        } catch let error {
            print("Error: \(error)")
        }
        return notices
    }
    
    //computer.knu.ac.kr 전체공지 변경
    func computer_total_notice_crawl(page : Int?) -> [Notice]?
       {
           var document : Document?
           var url = "http://computer.knu.ac.kr/06_sub/02_sub.html"
            let target_page : String  = "?page=" + String(page ?? 1)
            url = url + target_page
        document = downloadHTML(input_URL: url) ?? nil
           if(document == nil){
               return nil
           }
           var notices = [Notice]()
           let selector = "tbody>tr"
           do {
               //여기서  element객체를 css selector를 통해 파싱해서 element에 넣어줌.
               let elements: Elements = try document!.select(selector )
               //transform it into a local object (Item)
               for element in elements {
                   let num = try element.select(".bbs_num").text();
                   let title = try element.select("a").text()
                   let ref : String =  try element.select("a").attr("href")
                   let writer = try element.select(".bbs_writer").text()
                   let date = try element.select(".bbs_date").text()
                   let hit = try element.select(".bbs_hit").text()
                   let file = false
                   notices.append(Notice(num: num,title: title,ref: ref,wrtier: writer,date: date,hit: hit,file: file))
               }
               
           } catch let error {
               print("Error: \(error)")
           }
           return notices
       }
    
    
    
//    computer.knu.ac.kr 학사공지
    func computer_major_notice_crawl(URL : String?) -> [Notice]?
    {
        var document : Document?
    
        let url = URL ?? "http://computer.knu.ac.kr/06_sub/02_sub_2.html"
        document = downloadHTML(input_URL: url) ?? nil
        if(document == nil){
            return nil
        }
        var notices = [Notice]()
        let selector = "tbody>tr"
        do {
            //여기서  element객체를 css selector를 통해 파싱해서 element에 넣어줌.
            let elements: Elements = try document!.select(selector )
            //transform it into a local object (Item)
            for element in elements {
                let num = try element.select(".bbs_num").text();
                let title = try element.select("a").text()
                let ref : String =  try element.select("a").attr("href")
                let writer = try element.select(".bbs_writer").text()
                let date = try element.select(".bbs_date").text()
                let hit = try element.select(".bbs_hit").text()
                let file = false
                notices.append(Notice(num: num,title: title,ref: ref,wrtier: writer,date: date,hit: hit,file: file))
                //   print("num = \(num)" , "title = \(title)" , "title_to = \(ref)" , "writer = \(writer)" ,"date = \(date)" ,"hit = \(hit)" , "file 유무 : \(file)",separator : "\n")
                // print("========================================================")
            }
            
        } catch let error {
            print("Error: \(error)")
        }
        return notices
    }
    
    
    //computer.knu.ac.kr 학사공지 변경
       func computer_major_notice_crawl(page : Int?) -> [Notice]?
       {
           var document : Document?
           let target_page : String  = "?page=" + String(page ?? 1)
           var url = "http://computer.knu.ac.kr/06_sub/02_sub_2.html"
           url = url + target_page
           document = downloadHTML(input_URL: url) ?? nil
           if(document == nil){
               return nil
           }
           var notices = [Notice]()
           let selector = "tbody>tr"
           do {
               //여기서  element객체를 css selector를 통해 파싱해서 element에 넣어줌.
               let elements: Elements = try document!.select(selector )
               //transform it into a local object (Item)
               for element in elements {
                   let num = try element.select(".bbs_num").text();
                   let title = try element.select("a").text()
                   let ref : String =  try element.select("a").attr("href")
                   let writer = try element.select(".bbs_writer").text()
                   let date = try element.select(".bbs_date").text()
                   let hit = try element.select(".bbs_hit").text()
                   let file = false
                   notices.append(Notice(num: num,title: title,ref: ref,wrtier: writer,date: date,hit: hit,file: file))
               }

           } catch let error {
               print("Error: \(error)")
           }
           return notices
       }
    
    
    //학사일정
    func academic_calendar_crawl() -> [Calendar]?
    {
        var calendars = [Calendar]()
        var document : Document?
        let selector = "#calendar > dl"
        document = downloadHTML(input_URL: "http://knu.ac.kr/wbbs/wbbs/user/yearSchedule/index.action?menu_idx=43&schedule.search_year=2020") ?? nil
        if(document != nil)
        {
            do{
                let elements : Elements = try document!.select(selector)
                for element in elements{
                    print("==========================")
                    let full_date = try element.select("dt").text()
                    let year = Int(full_date.prefix(4))!
                    let start_index = full_date.index(full_date.startIndex,offsetBy: 5)
                    let end_index = full_date.index(full_date.startIndex, offsetBy: 6)
                    let month = Int(full_date[start_index...end_index]) ?? 0
                    
                    print(try element.select("dt").text())
                    
                    print("---------월 별 구분 ---------")
                    var schedules : [Schedule] = []
                    let fuck : Elements = try element.select(".list > ul > li")
                    for fucking in fuck{
                        let full_string = try fucking.text()
                        let day = String(full_string.prefix(8))
                        let index = full_string.index(full_string.startIndex,offsetBy: 8)
                        let content = String(full_string.suffix(from: index))
                        schedules.append(Schedule(day: day, content: content))
                        print("날짜 : " + day)
                        print("내용 : " + content)
                    }
                    calendars.append(Calendar(year: year, month: month, schedules: schedules))
                    print("===================")
                }
            }catch let error{
                print("error : \(error)")
            }
            return calendars
        }
        return nil
    }
    
    //학사일정 변경 year 따라 받을 수있도록 변경
    func academic_calendar_crawl(year : Int) -> [Calendar]?
    {
        var calendars = [Calendar]()
        var document : Document?
        let selector = "#calendar > dl"
        document = downloadHTML(input_URL: "http://knu.ac.kr/wbbs/wbbs/user/yearSchedule/index.action?menu_idx=43&schedule.search_year=" + String(year)) ?? nil
        if(document != nil)
        {
            do{
                let elements : Elements = try document!.select(selector)
                for element in elements{
                    print("==========================")
                    let full_date = try element.select("dt").text()
                    let year = Int(full_date.prefix(4))!
                    let start_index = full_date.index(full_date.startIndex,offsetBy: 5)
                    let end_index = full_date.index(full_date.startIndex, offsetBy: 6)
                    let month = Int(full_date[start_index...end_index]) ?? 0
                    
                    print(try element.select("dt").text())
                    
                    print("---------월 별 구분 ---------")
                    var schedules : [Schedule] = []
                    let fuck : Elements = try element.select(".list > ul > li")
                    for fucking in fuck{
                        let full_string = try fucking.text()
                        let day = String(full_string.prefix(8))
                        let index = full_string.index(full_string.startIndex,offsetBy: 8)
                        let content = String(full_string.suffix(from: index))
                        schedules.append(Schedule(day: day, content: content))
                        print("날짜 : " + day)
                        print("내용 : " + content)
                    }
                    calendars.append(Calendar(year: year, month: month, schedules: schedules))
                    print("===================")
                }
            }catch let error{
                print("error : \(error)")
            }
            return calendars
        }
        return nil
    }
    //교과과정(심컴기준 커리큘럼)
    func curriculum_crawl() -> [Curriculum]?
    {
        var curriculum = [Curriculum]()
        var year = 0
        var code : String = ""
        var name : String = ""
        var type : String = ""
        var point : String
        var necessary = false
        var design = false
        var document : Document?
        let selector = ".sub-table2 > tbody > tr"
        document = downloadHTML(input_URL: "http://computer.knu.ac.kr/03_sub/02_sub_2.html") ?? nil
        if(document != nil)
        {
            do{
                let elements : Elements = try document!.select(selector)
                for element in elements{
                    let sub_year = try element.select("th[rowspan]").text()
                    let sub_type = try element.select("td[rowspan]").first()?.text()
                    // print("====================")
                    if(sub_year != ""){
                        //   print(sub_year)
                        year = Int(sub_year) ?? 0
                    }
                    let fuckelements = try element.select("td")
                    var index = 0
                    for fuckelement in fuckelements
                    {
                        let fuck = try fuckelement.text()
                        if(fuck == sub_type){
                            type = fuck
                            // print(type)
                            continue
                        }
                        //    print(index, terminator : " ")
                        //  print(fuck)
                        switch(index % 3)
                        {
                        case 0 :
                            code = fuck
                            break
                        case 1 :
                            name = fuck
                            // print(try fuckelement.select("img[src*=icon-1]").isEmpty())
                            if(try !fuckelement.select("img[src*=icon-1]").isEmpty())
                            {
                                necessary = true
                            }
                            if(try !fuckelement.select("img[src*=icon-2]").isEmpty())
                            {
                                design = true
                            }
                            break
                        case 2 :
                            point = fuck
                            if(index / 3 == 0)
                            {
                                curriculum.append(Curriculum(year: year, semester: 1, type: type, code: code, name: name, point: point, necessary: necessary, design: design))
                            }
                            else{
                                curriculum.append(Curriculum(year: year, semester: 2, type: type, code: code, name: name, point: point, necessary: necessary, design: design))
                            }
                            necessary = false
                            design = false
                            break
                        default:
                            break
                        }
                        index += 1
                    }
                    // print("====================")
                }
            }catch let error{
                print("error : \(error)")
            }
            return curriculum
        }
        return nil
    }
    
    //수강한 전체 학기 받아 오기
    func time_table_semester_crawl(completiontHandler: @escaping (Result<[String],Error>) -> Void){
        let selector = "#search_set_cde > option"
        AF.request("http://abeek.knu.ac.kr/Keess/kees/web/stun/stunLectInfoEnq/list.action", method: .get).responseString{response in
            switch response.result
            {
            case .success(let html) :
                do{
                    var semesters = [String]()
                    //let html = try response.result.get()
                    var document : Document = Document.init("")
                    document = try SwiftSoup.parse(html)
                    let elements : Elements = try document.select(selector)
                    for element in elements{
                        semesters.append(try element.attr("value"))
                        //print(try element.attr("value"))
                    }
                    completiontHandler(.success(semesters))
                }catch{
                    completiontHandler(.failure(error))
                }
                break
            case .failure(let error) :
                print("error : \(error)")
               completiontHandler(.failure(error))
                break
            }
        }
    }
    
    //어떤 과목을 수강하고 있는지 받아와서 핸들러를 통해 수강하고있는 과목 정보를 전달.
    //학기 및 수업 코드 분반 번호 받아오기.
    func time_table_crawl(semester : String?, completiontHandler: @escaping (Result<[(String,String)],Error>) -> Void){
        let selector = ".left > a"
        
        let url : String = "http://abeek.knu.ac.kr/Keess/kees/web/stun/stunLectInfoEnq/list.action?lectInfo.open_yr_trm=" + String(semester ?? "")
        AF.request(url, method: .get).responseString{response in
            switch response.result
            {
            case .success(let html) :
                do{
                    var myCourse = [(Code : String,sub : String)]()
                    //let html = try response.result.get()
                    var document : Document = Document.init("")
                    document = try SwiftSoup.parse(html)
                    let elements : Elements = try document.select(selector)
                    for element in elements{
                        //print(try element.attr("href"))
                        let attr = try element.attr("href").getArrayAfterRegex(regex: "(?<=')[a-zA-Z0-9]*(?=')")
                        myCourse.append((attr[0], attr[1]))
                    }
                    completiontHandler(.success(myCourse))
                }catch{
                    completiontHandler(.failure(error))
                }
                break
            case .failure(let error) :
                print("error : \(error)")
                completiontHandler(.failure(error))
                break
            }
        }
    }
    
    //http://my.knu.ac.kr/stpo/stpo/cour/plans/viewPlanDetailNew.action?plans.searchOpenYrTrm=%2720191%27&plans.searchSubjCde=%27CLTR211%27&plans.searchSubClassCde=%27037%27
    //수강정보를 받아와서 강의계획서에서 시간표를 만들기위한 데이터로 처리하는 과정.
    func time_table_data_crawl(semester : String, Codes : [(Code : String, sub : String)]) -> [Timetable]?{
        let sub_url1 : String = "?plans.searchOpenYrTrm='" + semester + "''"
        var timeTables = [Timetable]()
        for data in Codes{
            var checkindex = 0
            var sub_course_name : String = ""
            var sub_course_id : String = ""
            var sub_professor : String = ""
            var sub_room : String = ""
            var sub_coursetime = [CourseTime]()
            let sub_url2 : String = "&plans.searchSubjCde='" + data.Code + "'&plans.searchSubClassCde='" + data.sub + "'"
            let url = "http://my.knu.ac.kr/stpo/stpo/cour/plans/viewPlanDetailNew.action" + sub_url1 + sub_url2
            var document : Document?
            document = downloadHTML(input_URL: url) ?? nil
            if(document == nil){
                print("url strange!")
                return nil
            }
            let selector = "#form1>tbody>tr>td"
            do {
                //여기서  element객체를 css selector를 통해 파싱해서 element에 넣어줌.
                let elements: Elements = try document!.select(selector)
                //transform it into a local object (Item)
                for element in elements {
                    switch checkindex {
                    case 0:
                        sub_course_name = try element.text()
                        break
                    case 1 :
                        sub_course_id = try element.text()
                        break
                    case 6 :
                        sub_professor = try element.text()
                        break
                    case 7 :
                        
                        let times = try element.text().components(separatedBy: " ")
                        for time in times {
                            let index = time.startIndex
                            let day = String(time[...index])
                            let detailtime = String(time[index...]).getArrayAfterRegex(regex : "[0-9]{1,}[A|B]")
                            let start = detailtime[detailtime.startIndex]
                            let end = detailtime[detailtime.endIndex - 1]
                            let course_startTime = TimeFormatChange(unformatted_time: start, type: 0)
                            let course_endTime = TimeFormatChange(unformatted_time: end, type: 1)
                            print("get after start translate : \(course_startTime)")
                            print("get after end translate : \(course_endTime)")
                                
                            sub_coursetime.append(CourseTime(courseDay: day, startTime: course_startTime, endTime: course_endTime))
                        }
                        break
                    case 8 :
                        let rooms = try element.text().components(separatedBy: " ")
                        sub_room = rooms[0]
                        break
                    default:
                        break;
                    }
                    checkindex = checkindex + 1
                    //print(try element.text())
                }
                timeTables.append(Timetable(courseId: sub_course_id, courseName: sub_course_name, professor: sub_professor, roomName: sub_room, courseTimes: sub_coursetime))
                sub_coursetime.removeAll()
            } catch let error {
                print("Error: \(error)")
            }
        }
//        for item in timeTables {
//            print(item.courseName)
//        }
        return timeTables
    }
    
    //0 : 이수성적, 1:필수과목이수내역 2:설계과목이수내역
    //쿠키 세션 태스크 같이 연결해서 써야되는거 같음 내일 ㄱ
    func grade_crawl(category type : Int, completiontHandler: @escaping (Result<[Grade],Error>) -> Void)
    {	
        //    print(Person_Info.sharedd.login_status)
        //      print(Person_Info.shared.cookie)
        var selector : String
        switch(type)
        {
        case 0 :
            selector = "fieldset#tab_FU > table > tbody > tr"
            break
        case 1 :
            selector = "fieldset#essentTab > table > tbody > tr"
            break
        case 2 :
            selector = "fieldset#designTab > table > tbody > tr"
            break
            
        default:
            selector = ""
            break
        }
        //쿠키 세팅(로그인 성공해야 후에 되는데 이거 조건 달아야..겟지?)
        // if(Person_Info.sharedInstance.login_status){
        //   Person_Info.sharedInstance.setCookies()
        // }
        
        
        //Person_Info.sharedInstance.setCookies()
        //print(
       // print("밖  \(Person_Info.shared.cookie)")
       // self.login()
        //self.setCookies()
//        print("**********************")
//        print(AF.session.configuration.httpCookieStorage?.cookies ?? "XXXXXXXXXXX")
//        print("**********************")
        AF.request("http://abeek.knu.ac.kr/Keess/kees/web/stue/stueStuRecEnq/list.action", method: .get).responseString{response in
            switch response.result
            {
            case .success(let html) :
                do{
                    var myGrade = [Grade]()
                    //let html = try response.result.get()
                    var document : Document = Document.init("")
                    var sub_code = ""
                    var sub_department = ""
                    var sub_name = ""
                    var sub_type = ""
                    var sub_gradeunit = ""
                    var sub_semester = ""
                    var sub_rating = ""
                    var recourse = false
                    document = try SwiftSoup.parse(html)
                    let elements : Elements = try document.select(selector)
                    for element in elements{
                        let subelement = try element.select("td")
                        var check_index = 1
                        recourse = false
                        for sub in subelement{
                            switch check_index {
                            case 1:
                                sub_code = try sub.text()
                                break
                            case 2 :
                                sub_department = try sub.text()
                                break
                            case 3:
                                sub_name = try sub.text()
                                break
                            case 4 :
                                sub_type = try sub.text()
                                break
                            case 5 :
                                sub_gradeunit = try sub.text()
                                break
                            case 6 :
                                sub_semester = try sub.text()
                                break
                            case 7 :
                                sub_rating = try sub.text()
                            case 8 :
                                recourse = true
                                break
                            default:
                                break
                            }
                            check_index = check_index + 1
                        }
                        if sub_code != ""
                        {
                            myGrade.append(Grade(code: sub_code, open_department: sub_department, name: sub_name, type: sub_type, grade_unit: Int(sub_gradeunit) ?? 0, semester: sub_semester, rating: sub_rating, retake: recourse))
                        }
//                        myGrade.append(Grade(code: attr[0], open_department: attr[1], name: attr[2], type: attr[3], grade_unit: Int(attr[4]) ?? 0 , semester: attr[5], rating: attr[6], retake: recourse))
                    }
                    completiontHandler(.success(myGrade))
                }catch{
                    completiontHandler(.failure(error))
                }
                break
            case .failure(let error) :
                print("error : \(error)")
                completiontHandler(.failure(error))
                break
            }
        }
    }
    
    
    //추후 진행 예정 마일리지 내용 없어서 안에 구조를 모름 ㅎ
    func mileage_crawl()
    {
        
    }
}


//정규식 사용을 위한 extension
//사용법은 다음과 같음
// let str =""
//str.getArrayAfterRegex(regexp) -> String 배열로 반환.
extension String{
    func getArrayAfterRegex(regex : String) -> [String] {
        do{
            let regex = try NSRegularExpression(pattern : regex)
            let results = regex.matches(in: self,  range: NSRange(self.startIndex..., in: self))
            return results.map{
                String(self[Range($0.range, in: self)!])
            }
        }catch let error{
            print("invalid regex : \(error.localizedDescription)")
            return []
        }
        
    }
}

