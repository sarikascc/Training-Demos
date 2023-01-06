//
//  TabBarVC.swift
//  TabBarDemo
//
//  Created by Sarika scc on 06/01/23.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = self.storyboard!.instantiateViewController(withIdentifier: "NaviOne") as! UINavigationController
        let vc2 = self.storyboard!.instantiateViewController(withIdentifier: "ScreenTwo") as! ScreenTwo
        let vc3 = self.storyboard!.instantiateViewController(withIdentifier: "ScreenThree") as! ScreenThree
        
        let item1 = UITabBarItem()
        item1.title = "Home"
        item1.image = UIImage(systemName: "homekit")
        
        let item2 = UITabBarItem()
        item2.title = "Rating"
        item2.image = UIImage(systemName: "star.fill")
        
        let item3 = UITabBarItem()
        item3.title = "Profile"
        item3.image = UIImage(systemName: "brain.head.profile")
        
        vc1.tabBarItem = item1
        vc2.tabBarItem = item2
        vc3.tabBarItem = item3
        
        self.viewControllers = [vc1, vc2,vc3]
        self.selectedIndex = 1
        
    }

}
