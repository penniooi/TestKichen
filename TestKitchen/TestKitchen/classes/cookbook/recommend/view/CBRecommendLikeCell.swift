//
//  CBRecommendLikeCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/17.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBRecommendLikeCell: UITableViewCell {
    
    //显示的数据
    var model: CBRecommendwidgetListModel?{
        
        didSet{
            //显示按钮的文字和属性
            showData()
        
        }
    
    
    }

   
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //显示图片和文字
    func showData(){
        
        for var i in 0..<8{
            //显示图片的model
            if model?.widget_data?.count>i{
                let imagemodel = model?.widget_data![i]
                if imagemodel?.type == "image"{
                    //获取图片视图
                    let index = i/2
                    let subView = self.contentView.viewWithTag(200+index)
                    if subView?.isKindOfClass(UIImageView.self) == true{
                        let imageView = subView as! UIImageView
                        imageView.kf_setImageWithURL(NSURL(string: (imagemodel?.content)!), placeholderImage: UIImage(named: "sdefaultImage.png"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }
            
            
            if model?.widget_data?.count>i+1{
            
                let textModel = model?.widget_data![i+1]
                if textModel?.type == "text"{
                    let subView = self.contentView.viewWithTag(300+i/2)
                    if subView?.isKindOfClass(UILabel.self) == true{
                            let label = subView as! UILabel
                            label.text = textModel?.content
                    
                    }
                
                
                }
            
            }
           
            i += 1

     
        }
    
    }
    
    //创建cell的方法
    
    class func creatLikeCellFor(tabView:UITableView,atIndexPath indexPath:NSIndexPath,withlistModel listModel:CBRecommendwidgetListModel)->CBRecommendLikeCell{
    
      
        
            //猜你喜欢
            let cellId = "CBRecommendLikeCellId"
            var cell = tabView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendLikeCell
            
            if nil == cell {
            
                cell = NSBundle.mainBundle().loadNibNamed("CBRecommendLikeCell", owner: nil, options: nil).last as? CBRecommendLikeCell
            
            }
            cell?.model = listModel
            
            return cell!
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
