//
//  CBRecommendHeaderView.swift
//  TestKitchen
//
//  Created by aloha on 16/8/19.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBRecommendHeaderView: UIView {
    //标题
    private var title:UILabel?
    //图片
    private var imageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //背景视图
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        let bgView = UIView.creatView()
        bgView.frame = CGRectMake(0,10,bounds.size.width,bounds.size.height-10)
        bgView.backgroundColor = UIColor.whiteColor()
        addSubview(bgView)
        //标题文字
        let titleW:CGFloat = 160
        let imageW:CGFloat = 30
        let x = (bounds.size.width-titleW-imageW)/2
        title = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(18), textAlignment: .Center, textColor: UIColor.blackColor())
        title!.frame = CGRectMake(x,10, titleW, bounds.size.height - 10)
        addSubview(title!)
        //右边图片
        imageView = UIImageView.creatImageView("more_icon")
        imageView?.frame = CGRectMake(x+titleW, 10, imageW, imageW)
        addSubview(imageView!)
    }
    
    func configTitle(title:String?){
    
        self.title?.text = title
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
