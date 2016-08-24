//
//  KTCSegmentController.swift
//  TestKitchen
//
//  Created by aloha on 16/8/23.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

protocol KTCSegmentControllerDelegate :NSObjectProtocol{
    func didSelectSegCtrl(segCtrl:KTCSegmentController,atIndex index:Int)
}

class KTCSegmentController: UIView {
    weak var delegate:KTCSegmentControllerDelegate?
    //选中按钮的序号
    var selectIndex = 0 {
    
        didSet{
            selectBtnAtIndex(selectIndex)
        
        }
    }
    //重新实现初始化方法
    //下划线视图
    private var lineView:UIView?
    
    /*
     titleNames是每个显示文字的数组
     */
    init(frame: CGRect,titleNames:[String]) {
        super.init(frame: frame)
        if titleNames.count>0{
            //按钮的宽度
            let w:CGFloat = bounds.size.width/CGFloat(titleNames.count)
            for i in 0..<titleNames.count{
                let frame = CGRectMake(CGFloat(i)*w, 0, w, bounds.size.height)
                let btn = KTCSegmentBnt(frame: frame)
                btn.configtitle(titleNames[i])
                btn.tag = 300+i
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
                addSubview(btn)
                //默认选中第一个
                if i == 0{
                    btn.clicked = true
                
                }
            
            }
            lineView = UIView.creatView()
            lineView?.backgroundColor = UIColor.redColor()
            lineView?.frame = CGRectMake(0, bounds.size.height-2, w, 2)
            addSubview(lineView!)
        
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectBtnAtIndex(index:Int){
        let curBtn = viewWithTag(300+index)
        if  curBtn?.isKindOfClass(KTCSegmentBnt.self)==true {
            let btn = curBtn as! KTCSegmentBnt
            btn.clicked = true
            if btn.tag != 300+selectIndex{
                //选中当前点击的按钮
                btn.clicked = true
                //取消上次点击的按钮的选中状态
                let lastBtn = viewWithTag(300+selectIndex)
                
                if lastBtn?.isKindOfClass(KTCSegmentBnt.self)==true{
                    let lastSegBtn = lastBtn as? KTCSegmentBnt
                    lastSegBtn?.clicked = false
                    
                }
                //修改当前选中的序号
                selectIndex = btn.tag - 300
               lineView?.frame.origin.x = (lineView?.bounds.size.width)! * CGFloat(selectIndex)
                
            }
        }

    }
    
    func clickBtn(btn:KTCSegmentBnt){
        if btn.tag != 300+selectIndex{
        //选中当前点击的按钮
        
        btn.clicked = true
        //取消上次点击的按钮的选中状态
        let lastBtn = viewWithTag(300+selectIndex)
        
        if lastBtn?.isKindOfClass(KTCSegmentBnt.self)==true{
            let lastSegBtn = lastBtn as? KTCSegmentBnt
            lastSegBtn?.clicked = false
        
        }
        //修改当前选中的序号
        selectIndex = btn.tag - 300
        selectBtnAtIndex(selectIndex)
        delegate?.didSelectSegCtrl(self, atIndex: selectIndex)
         lineView?.frame.origin.x = (lineView?.bounds.size.width)! * CGFloat(selectIndex)
        
        }
    }
}

class KTCSegmentBnt:UIControl{
    var clicked:Bool?{
        didSet{
            
        
            if clicked == true{
                label?.textColor = UIColor.blackColor()
            
            }else{
            
                label?.textColor = UIColor.grayColor()
            }
        
        }

    }
    
    private var label:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建文字的控件
        label = UILabel.createLabel("", font: UIFont.systemFontOfSize(24), textAlignment: .Center, textColor: UIColor.grayColor())
        label?.frame = self.bounds
        addSubview(label!)
    }
    
   
    
    //显示数据的方法
    func configtitle(title:String?){
        label?.text = title!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}