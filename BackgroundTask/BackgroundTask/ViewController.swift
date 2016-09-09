//
//  ViewController.swift
//  BackgroundTask
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 pengjf. All rights reserved.
//

import UIKit
let downURL = "http://count.cncrk.com/Download.asp?ID=85771&t=s5&sid=89180&URL=http://down.cncrk.com:8080/soft/keygen/&file=sourcetree.dmg"
class ViewController: UIViewController {

    @IBOutlet weak var progressView:UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //后台下载任务，只有在有WIFI的情况下才会运行
    @IBAction func backgroundTask(){
        let down = DownLoad.init(downLoadUrl: downURL)
        down.progressDown = {(session:NSURLSession,task:NSURLSessionDownloadTask,progress:Double) in
            print("----\(Float(progress))")
           dispatch_async(dispatch_get_main_queue(), { 
             self.progressView.progress = Float(progress)
           })
        }
    }
    //后台获取
    @IBAction func backgroundFetch(){
        
    }
    @IBAction func remotePush(){
        
    }
    @IBAction func requestTime(){
        
    }
    @IBAction func requestTimeforvor(){
        
    }

}

