//
//  CBSceneCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/22.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBSceneCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreImageView: UIImageView!
    
    
    func configTitle(title:String){
    
        self.nameLabel.text = title
    
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //创建cell的方法
    class func creatSceneCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel model:CBRecommendwidgetListModel)->CBSceneCell{
    
        var cell = tableView.dequeueReusableCellWithIdentifier("CBSceneCellId") as? CBSceneCell
        if cell == nil {
        
            cell = NSBundle.mainBundle().loadNibNamed("CBSceneCell", owner: nil, options: nil).last as? CBSceneCell
        }
        if model.title != nil{
            cell?.configTitle(model.title!)
        }
        return cell!
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
