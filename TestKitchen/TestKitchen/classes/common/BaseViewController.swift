//
//  BaseViewController.swift
//  TestKitchen
//
//  Created by aloha on 16/8/15.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addNavTitle(title:String){
        let titleLabel = UILabel.createLabel(title, font: UIFont.systemFontOfSize(24), textAlignment: .Center, textColor: UIColor.blackColor())
        self.navigationItem.titleView = titleLabel
    
    
    
    }
    
    //导航的按钮
    func addNavBtn(imageName:String,target:AnyObject?,isLeft:Bool,action:Selector){
        
        let btn = UIButton.createBtn(nil, bgImageName: imageName, selectBgImageName: nil, target: target, action: action)
        //chuang jian
        let barBtn = UIBarButtonItem(customView: btn)
        btn.frame = CGRectMake(0, 4, 40, 38)
        //3.显示导航
        if isLeft{
        
            navigationItem.leftBarButtonItem = barBtn
        
        }else{
        
            navigationItem.rightBarButtonItem = barBtn
        
        }
        
    
    }
    //返回按钮
    func addBackBtn(){
    
        self.addNavBtn("nav_back_black", target: self, isLeft: true, action: #selector(backAction))
    
    }
    func backAction(){
    
    
        self.navigationController?.popViewControllerAnimated(true)
    
    
    
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
