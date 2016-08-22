//
//  CBSpecialCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/19.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBSpecialCell: UITableViewCell {
    
    var model:CBRecommendwidgetListModel?{
        didSet{
        
        showData()
        }
}
    //进入类型的界面
    @IBAction func clickSceneBtn(sender: UIButton) {
    }
    
    @IBAction func clickDetailBtn(sender: UIButton) {
    }
    
    @IBAction func clickPlayBtn(sender: UIButton) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func showData(){
    
        //类型的图片
        if model?.widget_data?.count>0{
            let imageModel = model?.widget_data![0]
            if imageModel?.type == "image"{
                //获取类型按钮
                let subView = contentView.viewWithTag(100)
                if subView?.isKindOfClass(UIButton.self) == true{
                    let sceceBtn = subView as! UIButton
                    //设置按钮的背景图片
                    sceceBtn.kf_setBackgroundImageWithURL(NSURL(string: (imageModel?.content)!), forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
                }
            }
        
        }
        //类型的名字
        if model?.widget_data?.count>1{
            let nameModel = model?.widget_data![1]
            if nameModel?.type == "text"{
                let subView = contentView.viewWithTag(101)
                if subView?.isKindOfClass(UILabel.self) == true{
                    let nameLabel = subView as! UILabel
                    nameLabel.text = nameModel?.content
                
                }
            
            }
        
        }
        //类型的数量
        if model?.widget_data?.count>2{
            let numModel = model?.widget_data![2]
            if numModel?.type == "text"{
                let subView = contentView.viewWithTag(102)
                if subView?.isKindOfClass(UILabel.self) == true{
                
                    let nameLablel = subView as! UILabel
                    nameLablel.text = numModel?.content
                
                }

            }
        
        }
        
        
        //列举菜例的图片显示
        for i in 0..<4{
        
            //图片数据在数组中的序号 
            //index 
            let index = i*2+3
            if model?.widget_data?.count > index{
                let imageModel = model?.widget_data![index]
                //获取按钮视图
                if imageModel?.type == "image"{
                    let subView = contentView.viewWithTag(200+i)
                    if subView?.isKindOfClass(UIButton.self) == true{
                            let btn = subView as! UIButton
                            btn.kf_setBackgroundImageWithURL(NSURL(string: (imageModel?.content)!), forState: .Normal, placeholderImage: UIImage(named: "sdefaultImage" ), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        
                    }
                }
            }
        }
        
        //描述的文字
        let subView = contentView.viewWithTag(400)
        if subView?.isKindOfClass(UILabel.self)==true{
        
            let descLabel = subView as! UILabel
            descLabel.text = model?.desc
        
        }
    }
    
    
    //创建cell的方法
    class func creatSpecialCellFor(tabview:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendwidgetListModel)->CBSpecialCell{
            var cell = tabview.dequeueReusableCellWithIdentifier("specialCellId") as? CBSpecialCell
        if cell == nil {
        
            cell = NSBundle.mainBundle().loadNibNamed("CBSpecialCell", owner: nil, options: nil)
.last as? CBSpecialCell
        
        }
        cell?.model = listModel
        return cell!
    
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
