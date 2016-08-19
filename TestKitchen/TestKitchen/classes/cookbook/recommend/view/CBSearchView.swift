//
//  CBSearchView.swift
//  TestKitchen
//
//  Created by aloha on 16/8/18.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBSearchView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let searchBar = UISearchBar(frame: CGRectMake(0,0,bounds.size.width,bounds.size.height))
//        searchBar.placeholder = "输入菜名或者食材搜索"
//        //搜索框周围的颜色
//        searchBar.barTintColor = UIColor.whiteColor()
//        addSubview(searchBar)
        let textField = UITextField(frame: CGRectMake(40,4,bounds.size.width-40*2,bounds.size.height-4*2))
        textField.borderStyle = .RoundedRect
        textField.placeholder  = "输入菜名或食材搜索"
        addSubview(textField)
        backgroundColor = UIColor(white: 0.8 ,alpha: 1.0)
        
        //左边搜索的图片
        let imageView = UIImageView.creatImageView("search1")
        imageView.frame = CGRectMake(0, 0, 30, 30)
        textField.leftView = imageView
        textField.leftViewMode = .Always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
