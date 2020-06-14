//
//  WebViewController.swift
//  MAP2-20201
//
//  Created by semin on 2020/06/14.
//  Copyright © 2020 COMP420. All rights reserved.
//

import UIKit
import WebKit
class WebViewController : UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var myURLString : String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:myURLString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}

