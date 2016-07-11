//
//  DataModel.swift
//  MyScrollView
//
//  Created by 刘浩浩 on 16/7/11.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    /*
     *此模型不可省略，为的是传入图片链接，标题，链接地址，内容ID等数据
     */
    var imgURL:String!
    var title:String!
    var webLink:String!
    var contentID:String!

    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if  key == "id" {
            self.contentID = value as! String
        }
    }
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return nil
    }
    
    
}
