//
//  CookbookViewController.swift
//  TestKitchen
//
//  Created by aloha on 16/8/15.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit

class CookbookViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.creatMyNav()
        self.downloadRecommendData()
    }
    
    
    
    //下载推荐的数据
    func downloadRecommendData(){
      ////methodName=SceneHome&token=&user_id=&version=4.5
        let dict = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        
        let downloader = KTCDownloader()
        downloader.delegate  = self
        downloader.postWithUrlString(kHostUrl, params: dict)
    
    
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
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str!)
        
    }





}