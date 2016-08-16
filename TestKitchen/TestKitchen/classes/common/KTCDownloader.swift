//
//  KTCDownloader.swift
//  TestKitchen
//
//  Created by aloha on 16/8/16.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit
import Alamofire


public enum KTCDownloaderType:Int{

    case KTCDownloaderTypeDefault = 10
    

}

protocol KTCDownloaderDelegate:NSObjectProtocol {
    func downloader(downloader:KTCDownloader,didFailWithError error:NSError)
    func downloader(downloader:KTCDownloader,didFinishWithData data:NSData?)
   
}


class KTCDownloader: NSObject {
    ////methodName=SceneHome&token=&user_id=&version=4.5
    //代理属性一定要用weak修饰
    
    //用来区分不同下载的类型
    var type:KTCDownloaderType = KTCDownloaderType.KTCDownloaderTypeDefault
    
    weak var delegate:KTCDownloaderDelegate?
    
    func postWithUrlString(urlStr:String,params:Dictionary<String,String>?){
        Alamofire.request(.POST, urlStr, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result{
            case .Failure(let error):
                self.delegate?.downloader(self, didFailWithError: error)
            case .Success:
                self.delegate?.downloader(self, didFinishWithData: response.data!)
                
            }
        }
    
    }
    
}
