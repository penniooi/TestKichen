//
//  CBMaterialModel.swift
//  TestKitchen
//
//  Created by aloha on 16/8/23.
//  Copyright © 2016年 胡颉禹. All rights reserved.
//

import UIKit
import SwiftyJSON
class CBMaterialModel: NSObject {
    /*
     "code": "0",
     "msg": "success",
     "version": "4.0",
     "timestamp": 1471918382000,
     "data": {
     "id": 1,
     "text": "食材大全",
     "name": "crowd_type_tree",
     "data": [
     
     */
    var code:String?
    var msg:String?
    var version:String?
    var timestamp:NSNumber?
    var data:CBMaterialDataModel?
    class func parseModelWithData(data:NSData)->CBMaterialModel{
        let jsonData = JSON(data: data)
        let model = CBMaterialModel()
        model.code = jsonData["code"].string
        model.msg = jsonData["msg"].string
        model.version = jsonData["version"].string
        model.timestamp = jsonData["timestamp"].number
        let dataJson = jsonData["data"]
        model.data = CBMaterialDataModel.perseModel(dataJson)
        return model
    }
}


class CBMaterialDataModel:NSObject{
    
    var id:NSNumber?
    var text:String?
    var name:String?
    var data:Array<CBMaterialTypeModel>?
    
    class func perseModel(jsonData:JSON)->CBMaterialDataModel{
        let model = CBMaterialDataModel()
        model.id = jsonData["id"].number
        model.text = jsonData["text"].string
        model.name = jsonData["name"].string
        var array = Array<CBMaterialTypeModel>()
        
        for (_,subjson) in jsonData["data"]{
        
            let typModel = CBMaterialTypeModel.parseModel(subjson)
            array.append(typModel)
        
        }
        model.data = array
        return model
    }

}


class CBMaterialTypeModel:NSObject{
    var id:String?
    var text:String?
    var image:String?
    var data:Array<CBMaterialSubtypeModel>?
    class func parseModel(jsonData:JSON)->CBMaterialTypeModel{
    
        let model = CBMaterialTypeModel()
        model.id = jsonData["id"].string
        model.text = jsonData["text"].string
        model.image = jsonData["image"].string
        var array = Array<CBMaterialSubtypeModel>()
        for (_,subjson) in jsonData["data"]{
            let subModel = CBMaterialSubtypeModel.parseModel(subjson)
            array.append(subModel)
        
        }
        model.data = array
        return model
    }
}

class CBMaterialSubtypeModel:NSObject{
    var id:String?
    var text:String?
    var image:String?
    
    class func parseModel(jsonData:JSON)->CBMaterialSubtypeModel{
        let model = CBMaterialSubtypeModel()
        model.id = jsonData["id"].string
        model.text = jsonData["text"].string
        model.image = jsonData["image"].string
        return model
    }
    
}