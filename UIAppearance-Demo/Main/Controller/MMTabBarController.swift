//
//  MMTabBarController.swift
//  UIAppearance-Demo
//
//  Created by 买明 on 19/01/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class MMTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        
        // 全局
        setGlobalAppearance()
        
        // 部分
//        setLocalAppearance()

        setupAllChildControllers()
        setupAllTitleButton()
    }
    
    /*
     全局设置外观
    */
    func setGlobalAppearance() {
        var attrsNormal = [String : Any]()
        attrsNormal[NSFontAttributeName] = UIFont.systemFont(ofSize: 30)
        UITabBarItem.appearance().setTitleTextAttributes(attrsNormal, for: UIControlState.normal)
    }
    
    /*
     部分设置外观
     */
    func setLocalAppearance() {
        var attrsNormal = [String : Any]()
        attrsNormal[NSFontAttributeName] = UIFont.systemFont(ofSize: 30)
        UITabBarItem.appearance(whenContainedInInstancesOf: [MMTabBarController.self]).setTitleTextAttributes(attrsNormal, for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAllChildControllers() {
        // 添加子控制器
        let controller1 = UIViewController()
        let navController1 = UINavigationController(rootViewController: controller1)
        self.addChildViewController(navController1)
        
        // 添加子控制器
        let controller2 = UIViewController()
        let navController2 = UINavigationController(rootViewController: controller2)
        self.addChildViewController(navController2)
    }
    
    func setupAllTitleButton() {
        let navController1 = childViewControllers[0]
        navController1.tabBarItem.title = "1st"
        
        let navController2 = childViewControllers[1]
        navController2.tabBarItem.title = "2nd"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
