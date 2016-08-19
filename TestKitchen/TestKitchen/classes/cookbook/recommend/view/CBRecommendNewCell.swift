//
//  CBRecommendNewCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/19.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBRecommendNewCell: UITableViewCell {
    //显示数据
    var model:CBRecommendwidgetListModel?{
        didSet{
            showData()
        
        }
    }
    
    
    @IBAction func clickBtn(sender: UIButton) {
    }

    @IBAction func palyAction(sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showData(){
    
        for i in 0..<3{
            //图片
            if model?.widget_data?.count>i*4{
            
                let imagemodel = model?.widget_data![i*4]
                if imagemodel?.type == "image"{
                let dImage = UIImage(named: "sdefaultImage")
                let subView = contentView.viewWithTag(200+i)
                    if subView?.isKindOfClass(UIImageView.self) == true{
                            let imageView = subView as! UIImageView
                            imageView.kf_setImageWithURL(NSURL(string: (imagemodel?.content)!), placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    
                    }
    
                }
            
            }
            
            //视频
            
            
            //标题文字
            if model?.widget_data?.count > i*4+2{
                let titleModel = model?.widget_data![i*4+2]
                if titleModel?.type == "text"{
                    //获取标题的label
                    let subView = contentView.viewWithTag(400+i)
                    if subView?.isKindOfClass(UILabel.self) == true{
                        let titleLabel = subView as! UILabel
                        titleLabel.text = titleModel?.content
           
                    }
                
                }

            }
            //详情文字
            if model?.widget_data?.count > i*4+3{
                let descModel = model?.widget_data![i*4+3]
                if descModel?.type == "text"{
                    let subView = contentView.viewWithTag(500+i)
                    if subView?.isKindOfClass(UILabel.self) == true{
                        let descLabel = subView as! UILabel
                        descLabel.text = descModel?.content
           
                    }
                
                }

            }
        
        }
    
    }
    
    //创建cell的方法
    class func creatNewCellForTabView(tabView:UITableView,atIdexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendwidgetListModel)->CBRecommendNewCell{
        let  cellId = "NewCellId"
        var cell = tabView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendNewCell
        if nil == cell{
        
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendNewCell", owner: nil, options: nil).last as? CBRecommendNewCell
        
        }
        
        cell?.model = listModel
    
        return cell!
    
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
