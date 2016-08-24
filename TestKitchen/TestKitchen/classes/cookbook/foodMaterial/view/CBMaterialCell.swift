//
//  CBMaterialCell.swift
//  TestKitchen
//
//  Created by aloha on 16/8/24.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CBMaterialCell: UITableViewCell {
    
    var model:CBMaterialTypeModel?{
    
        didSet{
            if model != nil{
            showData()
            }
        }
    
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showData(){
        //1.删除之前的子视图
        for oldSub in contentView.subviews{
            oldSub.removeFromSuperview()
        
        }
        //添加子视图
        let titleLabel = UILabel.createLabel(model!.text, font: UIFont.systemFontOfSize(20), textAlignment: .Left, textColor: UIColor.blackColor())
            contentView.addSubview(titleLabel)
            titleLabel.frame = CGRectMake(20, 0, kScreenWidth-20*2, 40)
        //横向间距
        let spaceX:CGFloat = 10
        //纵向间距
        let spaceY:CGFloat = 10
        let colNum = 5
        //按钮的高度
        let h:CGFloat = 40
        //按钮的宽度
        let w = (kScreenWidth-spaceX*CGFloat(colNum+1))/CGFloat(colNum)
        //y的偏移量
        let offsetY:CGFloat = 40
        //标题
        //图片
        let imageFrame = CGRectMake(spaceX, offsetY, w*2+spaceX, h*2+spaceY)
        let imageView = UIImageView()
        imageView.frame = imageFrame
        imageView.kf_setImageWithURL(NSURL(string: (model?.image)!), placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(imageView)
        //循环创建按钮
        if model?.data?.count > 0{
        for i in 0..<(model?.data?.count)!{
            var btnFrame = CGRectZero
            if i < 6{
            //前两行的按钮
                let row = i/3
                let col = i%3
                btnFrame = CGRectMake(w*2+spaceX*3+CGFloat(col)*(w+spaceX), offsetY+CGFloat(row)*(h+spaceY), w, h)
              
            }else{
            //后面几行的按钮
                //计算行和列
                let row = (i-6)/5
                let col = (i-6)%5
                btnFrame = CGRectMake(spaceX+CGFloat(col)*(w+spaceX), offsetY+spaceY*2+h*2+CGFloat(row)*(h+spaceY), w, h)
            }
                let btn = CBMaterialBtn(frame: btnFrame)
                let submodel = model?.data![i]
                btn.model = submodel
                contentView.addSubview(btn)
        
            }
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func heightWithModel(model:CBMaterialTypeModel)->CGFloat{
        var h:CGFloat = 0
        let offsetY:CGFloat = 40
        let spaceY:CGFloat = 20
        let btnH:CGFloat = 40
      if  model.data?.count>0 {
        if model.data?.count<6{
            h = offsetY+(btnH+spaceY)*2
        
        }else{
            h = offsetY+(btnH+spaceY)*2
            //计算有多少行
            var rowNum = ((model.data?.count)!-6)/5
            if ((model.data?.count)!-6)%5>0{
                
                rowNum+=1
            
            }
            h+=CGFloat(rowNum)*(btnH+spaceY)
        }
        }
        return h
    }
    
}



class CBMaterialBtn:UIControl{
    private var titleLabel:UILabel?
    
    //数据的显示
    var model:CBMaterialSubtypeModel?{
    
        didSet{
            titleLabel?.text = model?.text
        }
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        titleLabel = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(17), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.frame = bounds
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}