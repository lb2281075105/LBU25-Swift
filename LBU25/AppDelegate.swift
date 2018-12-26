//
//  AppDelegate.swift
//  LBU25
//
//  Created by liubo on 2018/10/9.
//  Copyright © 2018年 刘博. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://app.u17.com")
    }()
    
    var orientation: UIInterfaceOrientationMask = .portrait
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configBase()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = LBUTabBarController()
        window?.makeKeyAndVisible()
        //MARK: 修正齐刘海
        //        UHairPowder.instance.spread()
        
        return true
    }
    
    func configBase() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        let defaults = UserDefaults.standard
        if defaults.value(forKey: String.sexTypeKey) == nil {
            defaults.set(1, forKey: String.sexTypeKey)
            defaults.synchronize()
        }
        
        reachability?.listener = { status in
            switch status {
            case .reachable(.wwan):
                UNoticeBar(config: UNoticeBarConfig(title: "主人,检测到您正在使用移动数据")).show(duration: 2)
            default: break
            }
        }
        reachability?.startListening()
    }

}

