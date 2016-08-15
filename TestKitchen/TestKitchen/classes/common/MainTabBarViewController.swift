//
//  MainTabBarViewController.swift
//  TestKitchen
//
//  Created by aloha on 16/8/15.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
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
        
        if let tmpArray = self.array{
        for dict in tmpArray{
        
            let name = dict["ctrlName"]
            ctrlNames.append(name!)
        
        }
        }else{
        
             ctrlNames = ["CookbookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
        
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
