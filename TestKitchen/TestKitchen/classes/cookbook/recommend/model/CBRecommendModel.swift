//
//  CBRecommendModel.swift
//  TestKitchen
//
//  Created by aloha on 16/8/16.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit
import SwiftyJSON

class CBRecommendModel: NSObject {
   
    
    var code:NSNumber?
    var msg:Bool?
    var version:String?
    var timestamp:NSNumber?
    var data:CBRecommendDataModel?
    //解析的方法
    class func parseModel(data:NSData)->CBRecommendModel{
        let model = CBRecommendModel()
        let jsonData = JSON(data: data)
        model.code = jsonData["code"].number
        model.msg = jsonData["msg"].bool
        model.version = jsonData["version"].string
        model.timestamp = jsonData["timestamp"].number
       let dataDict = jsonData["data"]
        model.data = CBRecommendDataModel.parseModel(dataDict)
        return model
    
    }
 }


class CBRecommendDataModel:NSObject{
    var banner:Array<CBRecommendBannerModel>?
    var widgetList:Array<CBRecommendwidgetListModel>?
    
    
    class func parseModel(jsonData:JSON)->CBRecommendDataModel{
        let model = CBRecommendDataModel()
        let bannerArray = jsonData["banner"]
        var bArray = Array<CBRecommendBannerModel>()
        for(_,subjson) in bannerArray{
        
            let bannerModel = CBRecommendBannerModel.parseModel(subjson)
            bArray.append(bannerModel)
            
            model.banner = bArray
        }
        let listArray = jsonData["widgetList"]
        var lArray = Array<CBRecommendwidgetListModel>()
        for (_,subjson) in listArray{
            
            let wlmodel = CBRecommendwidgetListModel.parseModel(subjson)
            lArray.append(wlmodel)
            
        }
            model.widgetList = lArray
        return model
    }

}


class CBRecommendBannerModel:NSObject{

/*
     "banner_id": 88,
     "banner_title": "秋葵鸡蛋卷",
     "banner_picture": "http://img.szzhangchu.com/1471257588171_9811390087.jpg",
     "banner_link": "app://food_course_series#58#",
     "is_link": 1,
     "refer_key": 18,
     "type_id": 1
     
     */

    var banner_id:NSNumber?
    var banner_title:String?
    var banner_picture:String?
    var banner_link:String?
    var is_link:NSNumber?
    var refer_key:NSNumber?
    var type_id:NSNumber?
    
    class func parseModel(jsonData:JSON)->CBRecommendBannerModel{
        let model = CBRecommendBannerModel()
        model.banner_id = jsonData["banner_id"].number
        model.banner_title = jsonData["banner_title"].string
        model.banner_picture = jsonData["banner_picture"].string
        model.banner_link = jsonData["banner_link"].string
        model.is_link = jsonData["is_link"].number
        model.refer_key = jsonData["refer_key"].number
        model.type_id = jsonData["type_id"].number
        return model
    
    }

}

class CBRecommendwidgetListModel:NSObject{

/*
     "widget_id": 32,
     "widget_type": 1,
     "title": "猜你喜欢",
     "title_link": null,
     "desc": null,
     "widget_data": [
     {
     
     
     */
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    var title:String?
    var title_link:String?
    var desc:String?
    var widget_data:Array<CBRecommendwidgetList_widget_data_Model>?
    //解析的方法
    class func parseModel(jsonData:JSON)->CBRecommendwidgetListModel{
        let model = CBRecommendwidgetListModel()
        model.widget_id = jsonData["widget_id"].number
        model.widget_type = jsonData["widget_type"].number
        model.title = jsonData["title"].string
        model.desc = jsonData["desc"].string
        model.title_link = jsonData["title_link"].string
        
        let dataArray = jsonData["widget_data"]
        var wdArray = Array<CBRecommendwidgetList_widget_data_Model>()
        for (_,subjson) in dataArray{
        
            let wdModel = CBRecommendwidgetList_widget_data_Model.parseModel(subjson)
            wdArray.append(wdModel)
        
        
        }
        model.widget_data = wdArray
        return model
    
    }

}

class CBRecommendwidgetList_widget_data_Model:NSObject{

    /*
     "id": 1,
     "type": "image",
     "content": "http://img.szzhangchu.com/1456222953065_6855615159.png",
     "link": "http://h5.izhangchu.com/Tour.html?app_hideheader=1"
     */

    var id:NSNumber?
    var type:String?
    var content:String?
    var link:String?


    class func parseModel(jsonData:JSON)->CBRecommendwidgetList_widget_data_Model{
        let model = CBRecommendwidgetList_widget_data_Model()
        model.id = jsonData["id"].number
        model.type = jsonData["type"].string
        model.content = jsonData["content"].string
        model.link = jsonData["link"].string
        return model
    
    }

}