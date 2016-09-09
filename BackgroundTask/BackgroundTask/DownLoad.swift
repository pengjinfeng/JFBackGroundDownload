//
//  DownLoad.swift
//  BackgroundTask
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 pengjf. All rights reserved.
//

import UIKit
import Foundation


typealias downLoadProgress = (session:NSURLSession,task:NSURLSessionDownloadTask,progress:Double) -> ()

class DownLoad: NSObject,NSURLSessionDelegate,NSURLSessionDownloadDelegate {
    
    var session:NSURLSession?
    var downloadTask:NSURLSessionDownloadTask?
    var progressDown:downLoadProgress?
    

    init(downLoadUrl:String) {
        super.init()
        
        self.startDownload(downLoadUrl)
    }
    
    //执行这个后台任务
    func startDownload(URLString:String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            let URL = NSURL.init(string: URLString)
            let reruest = NSURLRequest.init(URL: URL!)
            self.session = self.backgroundSession()
            self.downloadTask = self.session?.downloadTaskWithRequest(reruest)
            self.downloadTask?.resume()
        }
    }
    
    //创建一个后台任务
    func backgroundSession() -> NSURLSession {
         var sessions:NSURLSession?
        //创建一个带标识符的session
        var once:dispatch_once_t = dispatch_once_t.init()
        dispatch_once(&once) {
            let configer:NSURLSessionConfiguration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("com.www.yjzc.pengf")
            sessions = NSURLSession.init(configuration: configer, delegate: self, delegateQueue: nil)
        }
        return sessions!
    }
    
    //下载的一些代理方法
    //获取下载进度
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        if downloadTask == self.downloadTask {
            let progress = Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)
            if  progressDown != nil{
                progressDown!(session: session,task: downloadTask,progress: progress)
            }
            
        }
    }
    //必须实现的协议，完成下载的时候，复制文件到一个新的地方
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        //下载文件的转移，这里不再过多的描叙，点用这个方法之后零时文件就会被删除
        //刷新UI
        print("将要删除临时文件")
    }
    //任务完成时发送通知，如果error是nil那么就代表下载完成了
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error == nil {
           print("项目进展很顺利")
            let progress = task.countOfBytesReceived/task.countOfBytesExpectedToReceive
            print("下载的进度-----\(progress)")
        }else{
            print("---下载失败-error---\(error?.localizedDescription)")
        }
        
       
        //此时可以发送一个下载完成的本地通知
        
    }
  
}
