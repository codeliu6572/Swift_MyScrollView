//
//  ViewController.swift
//  MyScrollView
//
//  Created by 刘浩浩 on 16/7/11.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TopScrollViewDelegate {

    let _dataArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.orangeColor()
        // Do any additional setup after loading the view, typically from a nib.
        //获取本地json数据
        let path = NSBundle.mainBundle().pathForResource("Data", ofType: "json")
        guard let dataString = try? NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding) else {
            return
        }
        let data = dataString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let dic:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
        let focusImgs = dic["focusImgs"] as! NSArray
        //解析数据KVC
        for item in focusImgs {
            let dataModel = DataModel()
            dataModel.setValuesForKeysWithDictionary(item as! [String : AnyObject])
            _dataArray.addObject(dataModel)
        }
        let _topScrollView = TopScrollView(frame: CGRectMake(0, 64, WIDTH, 170), dataArray: _dataArray)
        _topScrollView.delegate = self
        self.view.addSubview(_topScrollView)
        
    }
    
    
    
    func didClickScrollView(index: NSInteger) {
        let view1VC = ViewController1()
        view1VC.webLink = (_dataArray[index] as! DataModel).webLink as String
        self.navigationController?.pushViewController(view1VC, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

