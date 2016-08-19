//
//  CookbookViewController.swift
//  TestKitchen
//
//  Created by aloha on 16/8/15.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CookbookViewController: BaseViewController {
    
    //食材首页的推荐视图
    private var recommentView:CBRecommenView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.creatMyNav()
        //初始化视图
        
        self.downloadRecommendData()
        creatHomePageView()
    }
    
    
    
    //下载推荐的数据
    func downloadRecommendData(){
      ////methodName=SceneHome&token=&user_id=&version=4.5
        let dict = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        
        let downloader = KTCDownloader()
        downloader.delegate  = self
        downloader.postWithUrlString(kHostUrl, params: dict)
    
    
    }
    
    func creatHomePageView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        recommentView = CBRecommenView()
        view.addSubview(recommentView!)
        
        recommentView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
    
    }
    
    func creatMyNav(){
    
        //扫一扫
        addNavBtn("saoyisao@2x", target: self, isLeft: true, action: #selector(scanAction))
        //搜索
        addNavBtn("search@2x", target: self, isLeft: false, action: #selector(searchAction))
    
    
    }
    
    
    func scanAction(){
    
    
    
    }
    
    func searchAction(){
    
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


//MARK:KTCDownloadDelegate

extension CookbookViewController:KTCDownloaderDelegate{

    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }

    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
//        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(str!)
        if let jsonData = data{
        
            let model = CBRecommendModel.parseModel(jsonData)
            dispatch_async(dispatch_get_main_queue(), {
                [weak self] in
                self!.recommentView?.model = model
            })
           
        
        }
        
    }





}