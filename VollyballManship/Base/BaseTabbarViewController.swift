//
//  BaseTabbarController.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/15.
//

import Foundation
import UIKit

class BaseTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .white
        creatChildViewControllers()
    }
    
    private func creatChildViewControllers() {
        let vc1 = VollyballViewController()
        vc1.tabBarItem.image = UIImage(named: "vollyball")?.withRenderingMode(.alwaysOriginal)
        vc1.tabBarItem.selectedImage = UIImage(named: "vollyballSelected")?.withRenderingMode(.alwaysOriginal)
        let navi1 = BaseNavigationController(rootViewController: vc1)
        
        let vc2 = ClockRecordViewController()
        vc2.tabBarItem.image = UIImage(named: "list")?.withRenderingMode(.alwaysOriginal)
        vc2.tabBarItem.selectedImage = UIImage(named: "listSelected")?.withRenderingMode(.alwaysOriginal)
        let navi2 = BaseNavigationController(rootViewController: vc2)
        
        let vc3 = MedalViewController()
        vc3.tabBarItem.image = UIImage(named: "medal")?.withRenderingMode(.alwaysOriginal)
        vc3.tabBarItem.selectedImage = UIImage(named: "medalSelected")?.withRenderingMode(.alwaysOriginal)
        let navi3 = BaseNavigationController(rootViewController: vc3)
        
        viewControllers = [navi1, navi2, navi3]
    }
}
