//
//  CBMaterialView.swift
//  TestKitchen
//
//  Created by aloha on 16/8/23.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBMaterialView: UIView {

    //表格
    private var tbView:UITableView?
    
    //数据
    var model:CBMaterialModel?{
        didSet{
            tbView?.reloadData()
        }
    }
    
    //初始化的方法
    init(){
        super.init(frame:CGRectZero)
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        addSubview(tbView!)
        //添加约束
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


//MARK:UITableView
extension CBMaterialView:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if model?.data?.data?.count>0{
            rowNum =  (model?.data?.data?.count)!
        }
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var h:CGFloat = 0
        //获取模型对象
        if model?.data?.data?.count>0{
        let typeModel =   model?.data?.data![indexPath.row]
            h = CBMaterialCell.heightWithModel(typeModel!)
        }
        return h
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       
            let cellId = "materialCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBMaterialCell
            if cell == nil{
                cell = CBMaterialCell(style: .Default, reuseIdentifier: cellId)
                
            }
            let typmodel = model?.data?.data![indexPath.row]
            cell?.model = typmodel
        
        
        return cell!
    }


}