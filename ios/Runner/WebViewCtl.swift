//
//  WebViewCtl.swift
//  Runner
//
//  Created by Caijinglong on 2018/4/13.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

import UIKit
import WebKit

class WebViewCtl :UIViewController,WKUIDelegate,WKNavigationDelegate{
    
    var url:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsLayout()
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
    
        
        if let u = URL(string: url){
            let request = URLRequest(url: u)
            webView.load(request)
        }
        self.view.addSubview(webView)
    }
    
}

class MyWebView :UIView{
    
    init(frame: CGRect,url:String) {
        super.init(frame: frame)
        
        let navigator = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
        navigator.backgroundColor = .white
        
        let close = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        close.setTitle("关闭", for: UIControlState.normal)
        close.setTitleColor(UIColor.black, for: UIControlState.normal)
        navigator.addSubview(close)
        close.addTarget(self, action: #selector(onClose), for: UIControlEvents.touchUpInside)
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 44, width: self.frame.width, height: self.frame.height))
        
        if let u = URL(string: url){
            let request = URLRequest(url: u)
            webView.load(request)
        }
        
        addSubview(navigator)
        addSubview(webView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onClose(){
        removeFromSuperview()
    }
}

