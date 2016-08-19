//
//  UIImageView+Util.swift
//  TestKitchen
//
//  Created by aloha on 16/8/17.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit


extension UIImageView{
    
    class func creatImageView(imageName:String?)->UIImageView{
        let imageView = UIImageView()
        if let name = imageName{
        
            imageView.image = UIImage(named: name)
        
        }
        return imageView
    }

}