//
//  TopScrollView.swift
//  MyScrollView
//
//  Created by 刘浩浩 on 16/7/11.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

import UIKit
//写在类别外面类似于#define
let WIDTH = UIScreen.mainScreen().bounds.size.width
let HEIGHT = UIScreen.mainScreen().bounds.size.height

protocol TopScrollViewDelegate {
    
    
    /*
     *UIScrollViewDelegate  协议方法，把点击的图片的位置传给使用者
     */
    
    func didClickScrollView(index:NSInteger)
    
    
}

class TopScrollView: UIView,UIScrollViewDelegate {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    var _mainScrollView = UIScrollView()
    var contentLabel = UILabel()
    var currentImageView = UIImageView()
    var _currentIndex: NSInteger!
    var _dataArray = NSMutableArray()
    var pageSubView = UIView()
    
    
    var delegate:TopScrollViewDelegate!
    /*
     *初始化scrollView及其部件
     */
    init(frame: CGRect, dataArray:NSMutableArray) {
        super.init(frame:frame)
        _mainScrollView.frame = CGRectMake(0, 0, WIDTH, 170)
        _mainScrollView.contentSize = CGSizeMake(WIDTH*3, 170)
        _mainScrollView.backgroundColor = UIColor.whiteColor()
        _mainScrollView.delegate = self
        _mainScrollView.pagingEnabled = true
        _mainScrollView.userInteractionEnabled = true
        _mainScrollView.showsHorizontalScrollIndicator = false
        _mainScrollView.showsVerticalScrollIndicator = false
        _mainScrollView.bounces = false;
        _mainScrollView.contentOffset = CGPointMake(WIDTH, 0)
        self.addSubview(_mainScrollView)
        _currentIndex = 0;
        _dataArray.setArray(dataArray as [AnyObject])
        self.setUpDataDataArray(_dataArray)
        self.cretPageControlAndTitle()
        // 手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapCLick))
        currentImageView.addGestureRecognizer(tap)
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    /*
     *此处为scrollView的复用，比目前网上大部分的同类型控件油画效果好，只需要三张图片依次替换即可实现轮播，不需要有几张图就使scrollView的contentSize为图片数＊宽度
     */
    func setUpDataDataArray(dataArray:NSArray) {
        for var view in _mainScrollView.subviews {
            if view.isKindOfClass(UIImageView) {
                view.removeFromSuperview()
            }
        }
        // 中间图
        currentImageView.sd_setImageWithURL(NSURL(string: (dataArray[_currentIndex] as! DataModel).imgURL as String))
        currentImageView.userInteractionEnabled = true;
        currentImageView.frame = CGRectMake(WIDTH, 0, WIDTH, 170);
        _mainScrollView.addSubview(currentImageView)
        // 左侧图
        let preImageView = UIImageView()
        let imageStr = _currentIndex - 1 >= 0 ? (dataArray[_currentIndex-1] as! DataModel).imgURL as String : (dataArray.lastObject as! DataModel).imgURL as String
        preImageView.userInteractionEnabled = true
        preImageView.sd_setImageWithURL(NSURL(string: imageStr))
        preImageView.frame = CGRectMake(0, 0, WIDTH, 170)
        _mainScrollView.addSubview(preImageView)
        // 右侧
        let nextImageView = UIImageView()
        let imageStr1 = _currentIndex + 1 < dataArray.count ? (dataArray[_currentIndex+1] as! DataModel).imgURL as String : (dataArray.firstObject as! DataModel).imgURL as String
        nextImageView.userInteractionEnabled = true
        nextImageView.sd_setImageWithURL(NSURL(string: imageStr1))
        nextImageView.frame = CGRectMake(WIDTH*2, 0, WIDTH, 170)
        _mainScrollView.addSubview(nextImageView)
        
    }
    /*
     *创建标题和pageControl，此处pageCOntrol为自定义的，如需要可修改为系统的，或更换图片即可
     */
    func cretPageControlAndTitle() {
        contentLabel.frame = CGRectMake(0, self.frame.size.height-30, WIDTH, 30);
        contentLabel.textAlignment = .Left;
        contentLabel.font = UIFont.systemFontOfSize(12)
        contentLabel.text = (_dataArray.firstObject as! DataModel).title as String
        contentLabel.backgroundColor = UIColor.blackColor()
        contentLabel.textColor = UIColor.whiteColor()
        contentLabel.alpha = 0.6;
        self.addSubview(contentLabel)
        
        
        pageSubView.frame = CGRectMake(0, self.frame.size.height-30, WIDTH, 30)
        pageSubView.backgroundColor = UIColor.clearColor()
        self.addSubview(pageSubView)
        
        for index in 0..<_dataArray.count {
            let imageView = UIImageView(image: UIImage.init(named: "News_Pic_Number02@2x.png"))
            imageView.frame = CGRectMake(WIDTH-(CGFloat(_dataArray.count)*12)-10+CGFloat(index)*12, 11, 7, 7)
            if index == 0
            {
                imageView.image = UIImage.init(named: "News_Pic_Number01@2x.png")
            }
            pageSubView.addSubview(imageView)
        }
        
        
    }
    
    /*
     *图片的代理点击响应方法
     */
    func tapCLick() {
        delegate.didClickScrollView(_currentIndex)
    }
    /*
     *定时器方法，使banner页无限轮播
     */
    func timerAction() {
        let imageView = pageSubView.subviews[_currentIndex] as! UIImageView
        imageView.image = UIImage.init(named: "News_Pic_Number02@2x.png")
        if _currentIndex+1 < _dataArray.count {
            _currentIndex = _currentIndex + 1;
        }
        else
        {
            _currentIndex=0;
        }
        
        UIView.animateWithDuration(1, animations: {
            self._mainScrollView.contentOffset = CGPointMake(WIDTH*2, 0)
            },completion: {
                (finished) in
                self._mainScrollView.contentOffset = CGPointMake(WIDTH, 0)
                self.setUpDataDataArray(self._dataArray)
        })
        
        
        contentLabel.text = (_dataArray[_currentIndex] as! DataModel).title as String
        let imageView1 = pageSubView.subviews[_currentIndex] as! UIImageView
        imageView1.image = UIImage.init(named: "News_Pic_Number01@2x.png")
    }
    
    /*
     *UIScrollViewDelegate  协议方法，拖动图片的处理方法
     */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == _mainScrollView
        {
            let imageView = pageSubView.subviews[_currentIndex] as! UIImageView
            imageView.image = UIImage.init(named: "News_Pic_Number02@2x.png")
            
            let index = scrollView.contentOffset.x/WIDTH;
            if index > 1
            {
                _currentIndex = _currentIndex + 1 < _dataArray.count ? _currentIndex+1 : 0;
                
                UIView.animateWithDuration(1, animations: {
                    self._mainScrollView.contentOffset = CGPointMake(WIDTH*2, 0)
                    },completion: {
                        (finished) in
                        self._mainScrollView.contentOffset = CGPointMake(WIDTH, 0)
                        self.setUpDataDataArray(self._dataArray)
                })
            }
            else if index < 1
            {
                _currentIndex = _currentIndex - 1 >= 0 ? _currentIndex-1 : _dataArray.count - 1;
                UIView.animateWithDuration(1, animations: {
                    self._mainScrollView.contentOffset = CGPointMake(0, 0)
                    },completion: {
                        (finished) in
                        self._mainScrollView.contentOffset = CGPointMake(WIDTH, 0)
                        self.setUpDataDataArray(self._dataArray)
                })
                
            }
            else
            {
                print("没滚动不做任何操作")
            }
            
            
            contentLabel.text = (_dataArray[_currentIndex] as! DataModel).title as String
            let imageView1 = pageSubView.subviews[_currentIndex] as! UIImageView
            imageView1.image = UIImage.init(named: "News_Pic_Number01@2x.png")
        }
        
        
        
    }
    
}








