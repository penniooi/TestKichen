//
//  CBRecommenView.swift
//  TestKitchen
//
//  Created by aloha on 16/8/17.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBRecommenView: UIView {

  //表格
    private var tbView:UITableView?
    
    //显示数据的对象
    var model:CBRecommendModel?{
        didSet{
            //刷新表格
            tbView?.reloadData()
        
        
        }
    
    }
    
    init(){
        super.init(frame:CGRectZero)
        //创建表格视图
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        
        //把分割线去掉
        tbView?.separatorStyle = .None
        addSubview(tbView!)
        
        //约束
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
    
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//UITabView的代理
extension CBRecommenView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var  sectionNum = 1
        if model?.data?.widgetList?.count>0 {
             sectionNum += (model?.data?.widgetList?.count)!
        }
       
        
        return sectionNum
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowNum = 0
        if section == 0{
            if model?.data?.banner?.count>0{
            
                rowNum = 1
            }
        }else{
            //其他的情况
            let listmodel = model?.data?.widgetList![section-1]
            if listmodel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
            
                rowNum = 1
            
            }else if listmodel?.widget_type?.integerValue == widgetType.RedPackage.rawValue{
                rowNum = 1
            
            }else if listmodel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
                rowNum = 1
            
            }else if listmodel?.widget_type?.integerValue == widgetType.Special.rawValue{
                //早餐日记,健康100岁等
                rowNum = 1
            
            }else if listmodel?.widget_type?.integerValue == widgetType.Secne.rawValue{
                //全部场景
                rowNum = 1
            
            }else if listmodel?.widget_type?.integerValue == widgetType.Talent.rawValue{
            
                rowNum = (listmodel?.widget_data?.count)!/4
            }
        
        
        }
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0{
            if model?.data?.banner?.count>0{
                height = 160
            
            }
        
        }else{
            let listmodel = model?.data?.widgetList![indexPath.section-1]
            if listmodel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
                //猜你喜欢
                height = 80
                
            }else if listmodel?.widget_type?.integerValue == widgetType.RedPackage.rawValue{
            
                height = 80
            }else if listmodel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
            
                height = 300
            
            }else if  listmodel?.widget_type?.integerValue == widgetType.Special.rawValue{
                height = 200
            
            }else if listmodel?.widget_type?.integerValue == widgetType.Secne.rawValue{
                height = 60
            }else if listmodel?.widget_type?.integerValue == widgetType.Talent.rawValue{
                height = 80
            }
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0{
            
            if model?.data?.banner?.count>0{
                cell = CBRecommendADCell.creatADCellForTabView(tableView, atIndexPath: indexPath, withModel: model!)
            
            }
            return cell
        
        }else{
        
            let listmodel = model?.data?.widgetList![indexPath.section-1]
            if listmodel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
                
                cell = CBRecommendLikeCell.creatLikeCellFor(tableView, atIndexPath: indexPath, withlistModel: listmodel!)
            }else if listmodel?.widget_type?.integerValue == widgetType.RedPackage.rawValue{
            
                cell = CBRedPacketCell.creatCBRedPacketCellFor(tableView, AtIndePath: indexPath, withModel: listmodel!)
            
            }else if listmodel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
            
                cell = CBRecommendNewCell.creatNewCellForTabView(tableView, atIdexPath: indexPath, withListModel: listmodel!)
            
            }else if listmodel?.widget_type?.integerValue == widgetType.Special.rawValue{
            
                cell = CBSpecialCell.creatSpecialCellFor(tableView, atIndexPath: indexPath, withListModel: listmodel!)
            
            }else if listmodel?.widget_type?.integerValue == widgetType.Secne.rawValue{
            
                cell = CBSceneCell.creatSceneCellFor(tableView, atIndexPath: indexPath, withListModel: listmodel!)
            
            
            }else if listmodel?.widget_type?.integerValue == widgetType.Talent.rawValue{
            
                cell = CBTalentCell.creatCBTalentCellFor(tableView, atIndexPath: indexPath, withListModel: listmodel!)
            
            }
            return cell
        
        }
     
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        var heightView:UIView? = nil
        
        if section > 0{
        let listmodel = model?.data?.widgetList![section-1]
        if listmodel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
            //猜你喜欢
            heightView = CBSearchView(frame: CGRectMake(0,0,kScreenWidth,44))
  
        }else if listmodel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
           let tmpView = CBRecommendHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
            tmpView.configTitle(listmodel?.title)
            heightView = tmpView
            
        }else if listmodel?.widget_type?.integerValue == widgetType.Special.rawValue{
            let tmpView = CBRecommendHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
            tmpView.configTitle(listmodel?.title)
            heightView = tmpView
        }else if listmodel?.widget_type?.integerValue == widgetType.Talent.rawValue{
            let tmpView = CBRecommendHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
            tmpView.configTitle(listmodel?.title)
            heightView = tmpView
            }
        }
        return heightView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height:CGFloat = 0
        if section > 0 {
        
            let listmodel = model?.data?.widgetList![section-1]
            if listmodel?.widget_type?.integerValue == widgetType.GuessYourLike.rawValue{
                //猜你喜欢
                height = 44
                
            }else if listmodel?.widget_type?.integerValue == widgetType.NewProduct.rawValue{
                height = 44
            
            }else if  listmodel?.widget_type?.integerValue == widgetType.Special.rawValue{
                height = 44
            }else if listmodel?.widget_type?.integerValue == widgetType.Talent.rawValue{
                //推荐达人
                height = 44
            }
        
        }
        return height
    }


}