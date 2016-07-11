//
//  ViewController1.swift
//  MyScrollView
//
//  Created by 刘浩浩 on 16/7/11.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    var webLink = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let webView = UIWebView(frame: self.view.bounds)
        webView.loadRequest(NSURLRequest(URL: NSURL(string: webLink as String)!))
        
        self.view.addSubview(webView)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
