//
//  FeedsDetailViewController.swift
//  WeatherDemo
//
//  Created by JinTian on 3/29/16.
//  Copyright © 2016 JinTian. All rights reserved.
//


import UIKit

class FeedsDetailViewController: UIViewController{

  
    @IBOutlet weak var webview: UIWebView!
    var urlid:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: urlid!)
        webview.loadRequest(NSURLRequest(URL: url!))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
