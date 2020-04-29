//
//  Person_Info.swift
//  MAP2-20201
//
//  Created by pcrmcw0486 on 2020/04/27.
//  Copyright © 2020 COMP420. All rights reserved.
//

import Foundation

//swift getter setter는 프로퍼티를 사용한다.
/*참조 : https://medium.com/ios-development-with-swift/%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0-get-set-didset-willset-in-ios-a8f2d4da5514*/

class Person_Info
{
    static let sharedInstance = Person_Info()
    
    private var _name : String = ""
    private var _id : String = ""
    private var _passwd : String = ""
    private var _student_num : String = ""
    public var name : String{
        get{
            return _name
        }
        set(input_name){
            _name = input_name
        }
    }
    public var id : String{
        get{
            return _id
        }
        set(input_id)
        {
            _id = input_id
        }
    }
    public var passwd : String{
        get{
            return _passwd
        }
        set(input_pw)
        {
            _passwd = input_pw
        }
    }
    public var student_num : String{
        get{
            return _student_num
        }
        set(input_std_num){
            _student_num = input_std_num
        }
    }
    init()
    {
        self.name = _name
        self.id = _id
        self.passwd = _passwd
        self.student_num = _student_num
    }
    
    //yes에 로그인 쿠키 받아오기.
    func login()
    {
        
    }
    
}
