//
//  ViewController.swift
//  UIAppearance-Demo
//
//  Created by 买明 on 19/01/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        MMButton.appearance().btnBorderWidth = CGFloat(10.0)
        
        let mmControllerButton = MMButton(type: .custom)
        mmControllerButton.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: 100)
        mmControllerButton.backgroundColor = UIColor.red
        mmControllerButton.setTitle("MM 控制器跳转", for: .normal)
        mmControllerButton.addTarget(self, action: #selector(mmButtonClick), for: .touchUpInside)
        view.addSubview(mmControllerButton)
        
        let vvControllerButton = MMButton(type: .custom)
        vvControllerButton.frame = CGRect(x: 0, y: 164, width: view.frame.width, height: 100)
        vvControllerButton.backgroundColor = UIColor.blue
        vvControllerButton.setTitle("VV 控制器跳转", for: .normal)
        vvControllerButton.addTarget(self, action: #selector(vvButtonClick), for: .touchUpInside)
        view.addSubview(vvControllerButton)
    }
    
    func mmButtonClick() {
        navigationController?.pushViewController(MMTabBarController(), animated: true)
    }
    
    func vvButtonClick() {
        navigationController?.pushViewController(VVTabBarController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

