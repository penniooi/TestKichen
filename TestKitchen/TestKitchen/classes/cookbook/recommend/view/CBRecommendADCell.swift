//
//  CBRecommendADCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/17.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBRecommendADCell: UITableViewCell {
  
    @IBOutlet weak var scorllView: UIScrollView!
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    
    var bannerArray:Array<CBRecommendBannerModel>?{
        didSet{
            showData()
        
        }
    
    
    }
    
    
    //创建cell的方法
    
    class func creatADCellForTabView(tabView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:CBRecommendModel)->CBRecommendADCell{
        
            var cell = tabView.dequeueReusableCellWithIdentifier("RecommendADCellId") as? CBRecommendADCell
            if nil == cell{
                cell = NSBundle.mainBundle().loadNibNamed("CBRecommendADCell", owner: nil, options: nil).last as? CBRecommendADCell
        
        
        }
        cell?.bannerArray = model.data?.banner
        
        return cell!
    }
    
    
    
    func showData() {
        
        let cnt = bannerArray?.count
        if cnt>0 {
            //0.添加一个容器视图
            let containerView = UIView.creatView()
            scorllView.addSubview(containerView)
            //设置约束
            containerView.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.edges.equalTo(self!.scorllView)
                make.height.equalTo(self!.scorllView)
            })
            
            var lastView:UIView? = nil
            for i in 0..<cnt!{
                //获取模型对象
                let model = bannerArray![i]
                //循环创建图片的方法
                let tmpimageView = UIImageView.creatImageView(nil)
                //在线加载图片
                //第一个参数:图片网址的url
                //第二个参数:默认图片
                //第三个参数:选项
                //第四个参数:可以获取下载的进度
                //第五个参数:下载数据结束时候的操作
                tmpimageView.kf_setImageWithURL(NSURL(string: model.banner_picture!), placeholderImage: UIImage(named:"sdefaultImage.png"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpimageView)
                //约束
                tmpimageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(kScreenWidth)
                    if i == 0 {
                    
                        make.left.equalTo(containerView)
                    
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                
                lastView = tmpimageView
                
            }
            //修改容器视图的约束
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
            //修改分页控件
            self.pageCtrl.numberOfPages = cnt!
            scorllView.pagingEnabled = true
            scorllView.delegate = self
        }
       
        
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

extension CBRecommendADCell:UIScrollViewDelegate{

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        pageCtrl.currentPage = index
    }
    


}