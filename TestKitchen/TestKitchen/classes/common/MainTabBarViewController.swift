//
//  MainTabBarViewController.swift
//  TestKitchen
//
//  Created by aloha on 16/8/15.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit


class MainTabBarViewController: UITabBarController {
    //自定制背景视图
    private var bgView:UIView?
    
    //json对应的数组
    var array:Array<Dictionary<String,String>>?{
    
        get{
            //读文件
            let path = NSBundle.mainBundle().pathForResource("Ctrl", ofType: "json")
            var  myArray:Array<Dictionary<String,String>>? = nil
            
            if  let filePath = path {
                let data = NSData(contentsOfFile: filePath)
                    do {
                    
                     let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        if  jsonData.isKindOfClass(NSArray.self) {
                            let tmpArray = jsonData as! Array<Dictionary<String,String>>
                              myArray = tmpArray
                        }
                    }catch{
                        //程序出现异常
                        print(error)
                        return nil
                    
                }
             
            }
            return myArray
        }

    }
    
    //自定制tabbar
    func createCustomTabbar(titleNames:[String],imageNames:[String]){
        self.bgView = UIView.creatView()
        self.view.addSubview(self.bgView!)
        //添加约束
        self.bgView?.snp_makeConstraints(closure: {
                [weak self]
            (make) in
        
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view.snp_bottom).offset(-49)
            self?.bgView?.layer.borderWidth = 2
            self?.bgView?.layer.borderColor = UIColor.grayColor().CGColor
            self!.view.addSubview((self?.bgView!)!)
        })
        //循环添加按钮
        //按钮的宽度
        let wight = kScreenWidth/5.0
        for i in 0..<imageNames.count{
            let imageName = imageNames[i]
            let titleName = titleNames[i]
            //2.1按钮
            let btn = UIButton.createBtn(nil, bgImageName: imageName+"_normal", selectBgImageName: imageName+"_select", target: self, action: #selector(clickBtn(_:)))
            self.bgView?.addSubview(btn)
            //添加约束
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(wight)
                make.left.equalTo(wight*CGFloat(i))
            })
            //2.2文字
            let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(8), textAlignment: .Center, textColor: UIColor.grayColor())
            btn.addSubview(label)
            btn.tag = 500+i
            //约束
            label.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(12)
            })
            label.tag = 400
            //默认选中第一个按钮
            if i == 0{
                btn.selected = true
                label.textColor = UIColor.orangeColor()
            
            }
        }
    
    }
    
    func clickBtn(curBtn:UIButton){
        //1.取消之前的选中状态
        let lastBtnView = self.view.viewWithTag(500+selectedIndex)
        if let tmpBtn = lastBtnView{
            let lastBtn = tmpBtn as! UIButton
            let lastLabelView = tmpBtn.viewWithTag(400)
            if let tmpLabel = lastLabelView{
                let lastLabel = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
        
        }
        
        //2.设置当前的选中状态
        let curLabelView = curBtn.viewWithTag(400)
        
        if let tmpLabel = curLabelView{
            let curLabel = tmpLabel as! UILabel
            curBtn.selected = true
            curLabel.textColor = UIColor.orangeColor()
        
        }
        //选中视图控制器
        selectedIndex = curBtn.tag - 500
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        creatViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //创建视图控制器
    func creatViewControllers(){
       // let ctrlNames = ["CookbookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
        var ctrlNames = [String]()
        var imageNames = [String]()
        var titleNames = [String]()
        
        
        if let tmpArray = self.array{
        for dict in tmpArray{
        
            let name = dict["ctrlName"]
            let imageName = dict["imageName"]
            let titleName = dict["titleName"]
            ctrlNames.append(name!)
            imageNames.append(imageName!)
            titleNames.append(titleName!)
        }
        }else{
        
             ctrlNames = ["CookbookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            //home_normal@2x,home_select@2x  community_normal@2x,community_select@2x  ,shop_normal@2x,shop_select@2x  
            //shike_normal@2x  shike_select@2x mine_normal@2x,mine_select@2x
            titleNames = ["食材","社区","商城","时刻","我的"]
            imageNames = ["home","community","shop","shike","mine"]
          
        
        }
        
        var vCtrlArray = Array<UINavigationController>()
        for i in 0..<ctrlNames.count{
            let ctrlName = "TestKitchen." + ctrlNames[i]
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let ctrl = cls.init()
            //导航
            let navCtrl = UINavigationController(rootViewController: ctrl)
            vCtrlArray.append(navCtrl)
        
        }
        self.viewControllers = vCtrlArray
        self.createCustomTabbar(titleNames, imageNames: imageNames)
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
