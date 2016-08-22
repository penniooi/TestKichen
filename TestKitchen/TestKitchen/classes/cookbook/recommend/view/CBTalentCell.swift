//
//  CBTalentCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/22.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBTalentCell: UITableViewCell {
    @IBOutlet weak var talentImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var fansLabel: UILabel!
    
    var dataArray:Array<CBRecommendwidgetList_widget_data_Model>?{
        
        didSet{
            showData()
        
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func showData(){
        //图片
        if dataArray?.count > 0{
            let imageModel = dataArray![0]
            if imageModel.type == "image"{
            
                talentImageView.kf_setImageWithURL(NSURL(string: imageModel.content!), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
            }
        
        }
        //名字
        if dataArray?.count>1{
            let nameModel = dataArray![1]
            if nameModel.type == "text"{
                self.nameLabel.text = nameModel.content
            }
        
        }
        //描述文字
        if dataArray?.count>2{
            let descModel = dataArray![2]
            if descModel.type == "text"{
                self.descLabel.text = descModel.content
            
            }
        
        }
        //粉丝
        if dataArray?.count>3{
            let fansModel = dataArray![3]
            if fansModel.type == "text"{
                self.fansLabel.text = fansModel.content
            
            }
        }
    }
    
    //创建cell的方法
    class func creatCBTalentCellFor(tabView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendwidgetListModel)->CBTalentCell{
    
        var  cell = tabView.dequeueReusableCellWithIdentifier("CBTalentCellId") as? CBTalentCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CBTalentCell", owner: nil, options: nil).last as? CBTalentCell
        
        }
        
        if listModel.widget_data?.count>indexPath.row*4+3{
        let array = NSArray(array: listModel.widget_data!)
        
        let curArray = array.subarrayWithRange(NSMakeRange(indexPath.row*4, 4))
            cell?.dataArray = curArray as? Array<CBRecommendwidgetList_widget_data_Model>
        }
        return cell!
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
