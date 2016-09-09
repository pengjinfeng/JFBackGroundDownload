//
//  AppDelegate.swift
//  BackgroundTask
//
//  Created by apple on 16/9/7.
//  Copyright © 2016年 pengjf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var bgTask:UIBackgroundTaskIdentifier?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.backgroundFetch()
        
        
        return true
    }
    //设置fetch的时间，默认是永远不执行
    //测试的时候可以设置一下scheme
    func backgroundFetch() {
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        print("执行了backgroundFetch的方法")
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.backgroundHandle()
    }
//后台运行向系统申请时间，一般都是10分钟
    func backgroundHandle() {
        self.bgTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler {
        
        dispatch_async(dispatch_get_main_queue(), { 
            

            if self.bgTask != UIBackgroundTaskInvalid{
                self.bgTask = UIBackgroundTaskInvalid
            }
            
            print("完成任务")
//  申请时间之后完成呢过任务需要结束申请          UIApplication.sharedApplication().endBackgroundTask(self.bgTask!)
        })
        
// 无限运行后台代码
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
            while true{
                print("无限执行的后台")
                sleep(5)
            }
        })
        
        
        }
    }
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

