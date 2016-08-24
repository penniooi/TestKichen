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
    
    //首页的食材视图
    private var foodView:CBMaterialView?
    
    //分类视图
    private var categoryView:CBMaterialView?
    
    //导航的标题视图
    private var segCtrl:KTCSegmentController?
    
    //滚动视图
    private var scrollerView:UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.creatMyNav()
        //初始化视图
        
        self.downloadRecommendData()
        downloadFoodData()
        downloadCategoryData()
        creatHomePageView()
    }
    
    //下载食材的数据
    func downloadFoodData(){
     //methodName=MaterialSubtype&token=&user_id=&version=4.32
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloader()
        downloader.type = .FoodMaterial
        downloader.delegate = self
        downloader.postWithUrlString(kHostUrl, params: dict)
    }
    
    
    //下载推荐的数据
    func downloadRecommendData(){
      ////methodName=SceneHome&token=&user_id=&version=4.5
        let dict = ["methodName":"SceneHome"]
        
        let downloader = KTCDownloader()
        downloader.delegate  = self
        downloader.postWithUrlString(kHostUrl, params: dict)
        downloader.type = .Recommend
    
    
    }
    
    //下载分类的数据
    func downloadCategoryData(){
        let dict = ["methodName":"CategoryIndex"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .Category
        downloader.postWithUrlString(kHostUrl, params: dict)
        
    }
    
    func creatHomePageView(){
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //创建一个滚动视图
         scrollerView = UIScrollView()
        scrollerView!.pagingEnabled = true
        scrollerView?.delegate = self
        view.addSubview(scrollerView!)
        scrollerView!.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        
        //添加scroller上的容器视图
        let containerView = UIView.creatView()
        scrollerView!.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalTo(scrollerView!)
            make.height.equalTo(scrollerView!.snp_height)
        }
        
        //添加子视图
        
        //推荐
        recommentView = CBRecommenView()
        containerView.addSubview(recommentView!)
        
        recommentView?.snp_makeConstraints(closure: {
          
            (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo(containerView)
        })
        
        //食材
        foodView = CBMaterialView()
        foodView?.backgroundColor = UIColor.cyanColor()
        containerView.addSubview(foodView!)
        //约束
        foodView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommentView?.snp_right)!)
        })
        //分类
        categoryView = CBMaterialView()
        categoryView?.backgroundColor = UIColor.blueColor()
        containerView.addSubview(categoryView!)
        //约束
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((foodView?.snp_right)!)
        })
        
        //
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
    
    }
    
    func creatMyNav(){
        //标题位置
        segCtrl = KTCSegmentController(frame: CGRectMake(80, 0, kScreenWidth-80*2, 44), titleNames: ["推荐","食材","分类"])
        navigationItem.titleView = segCtrl
        segCtrl?.delegate = self
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
       
        
        if downloader.type == .Recommend{
        
            if let jsonData = data{
                
                let model = CBRecommendModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.recommentView?.model = model
                    })
            }
        
        }else if downloader.type == .FoodMaterial{
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(str!)
            
            if let jsonData = data{
            let model = CBMaterialModel.parseModelWithData(jsonData)
                dispatch_async(dispatch_get_main_queue(), { 
                    [weak self] in
                    self!.foodView?.model = model
                })
            }
        }else if downloader.type == .Category{
            if let jsonData = data{
            let model = CBMaterialModel.parseModelWithData(jsonData)
            dispatch_async(dispatch_get_main_queue(), {
                [weak self] in
                self!.categoryView?.model = model
                })
            }
        }
       
        
    }

}

extension CookbookViewController:KTCSegmentControllerDelegate{

    func didSelectSegCtrl(segCtrl: KTCSegmentController, atIndex index: Int) {
        scrollerView?.setContentOffset(CGPointMake(kScreenWidth*CGFloat(index), 0), animated: true)

    }
}

extension CookbookViewController:UIScrollViewDelegate{

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int((scrollerView?.contentOffset.x)!/(scrollerView?.bounds.width)!)
        segCtrl?.selectBtnAtIndex(index)
        
    }


}