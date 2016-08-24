//
//  CBSubjectCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/23.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit


class CBSubjectCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var subjectImageVIEW: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var dataArray:Array<CBRecommendwidgetList_widget_data_Model>?{
        
        didSet{showData()
        }
    }
    
    func showData(){
        if dataArray?.count > 0 {
            let imageModel = self.dataArray![0]
            if imageModel.type == "image"{
                subjectImageVIEW?.kf_setImageWithURL(NSURL(string: imageModel.content!), placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                
            }
        
        }
        if dataArray?.count>1{
            let namemodel = self.dataArray![1]
            if namemodel.type == "text" {
            
                titleLabel.text = namemodel.content
            
            }
        
        }
        
        if dataArray?.count>2{
            let namemodel = self.dataArray![2]
            if namemodel.type == "text" {
                
                descLabel.text = namemodel.content
                
            }
            
        }

    }
    
    class func createSubjectCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendwidgetListModel)->CBSubjectCell{
        var cell = tableView.dequeueReusableCellWithIdentifier("CBSubjectCellId") as? CBSubjectCell
        if cell == nil{
            
            cell = NSBundle.mainBundle().loadNibNamed("CBSubjectCell", owner: nil, options: nil).last as? CBSubjectCell
        
        }
       
        if listModel.widget_data?.count > indexPath.row*3+2{
            let  array = NSArray(array: listModel.widget_data!)
            cell?.dataArray = array.subarrayWithRange(NSMakeRange(indexPath.row*3, 3)) as? Array<CBRecommendwidgetList_widget_data_Model>
            
        
        }
        
       
        
        return cell!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
