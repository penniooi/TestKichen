//
//  CBRedPacketCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/18.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBRedPacketCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var model:CBRecommendwidgetListModel?{
        didSet{
        
            showData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showData(){
        //删除之前的子视图
        for sub in scrollView.subviews{
            sub.removeFromSuperview()
            
        }
        
        //1.容器视图
        let containeView = UIView.creatView()
        scrollView.addSubview(containeView)
        scrollView.showsHorizontalScrollIndicator = false
        containeView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView.snp_height)
        }
    
        //2.循环添加图片
        var lastView:UIView? = nil
        if model?.widget_data?.count > 0 {
            for i in 0..<(self.model?.widget_data?.count)!{
                let imageModel = model?.widget_data![i]
                if imageModel?.type == "image"{
                    let image = UIImageView.creatImageView(nil)
                    let url = NSURL(string: (imageModel?.content)!)
                    image.kf_setImageWithURL(url)
                    containeView.addSubview(image)
                    
                    
                    
                    //约束
                    image.snp_makeConstraints(closure: { (make) in
                        make.top.bottom.equalTo(containeView)
                        make.width.equalTo(180)
                        if i == 0{
                        make.left.equalTo(0)
                        
                        }else{
                        make.left.equalTo((lastView?.snp_right)!)
                        
                        }
                        
                    })
                    //添加点击事件
                    image.userInteractionEnabled = true
                    image.tag = 400+i
                    //手势
                    let g = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
                    image.addGestureRecognizer(g)
                    
                    lastView = image
                }
            }
            
            //修改容器的大小
            containeView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
        }
    }
    
    func tapAction(g:UITapGestureRecognizer){
    
        print((g.view?.tag)!-400)
        
    
    
    }
    
    //创建cell的方法
    class func creatCBRedPacketCellFor(tabView:UITableView,AtIndePath:NSIndexPath,withModel listModel:CBRecommendwidgetListModel)->CBRedPacketCell{
        let cellId = "redParketCellId"
        var cell = tabView.dequeueReusableCellWithIdentifier(cellId) as? CBRedPacketCell
        if nil == cell{
        
            cell = NSBundle.mainBundle().loadNibNamed("CBRedPacketCell", owner: nil, options: nil).last as? CBRedPacketCell
        
        }
    
            cell?.model = listModel
        return cell!
    
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



