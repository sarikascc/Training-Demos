//
//  PageViewController.swift
//  PageViewDemo
//
//  Created by Sarika scc on 03/06/22.
//

import UIKit

class PageViewController: UIPageViewController ,UIPageViewControllerDataSource {
    
    var individualPageViewControllerList = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        dataSource = self
        
        let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstVC") as! FirstVC
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondVC") as! SecondVC
        let thirdVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ThirdVC") as! ThirdVC
       
        individualPageViewControllerList = [
            firstVC,
            secondVC,
            thirdVC
        ]
        
        setViewControllers([individualPageViewControllerList[0]], direction: .forward, animated: true, completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController)!
        
        if indexOfCurrentPageViewController == 0 {
            
            return nil
        }
        else
        {
            return individualPageViewControllerList[indexOfCurrentPageViewController - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let indexOfCurrentPageViewController = individualPageViewControllerList.firstIndex(of: viewController)!
        
        if indexOfCurrentPageViewController == individualPageViewControllerList.count - 1 {
            
            return nil // To show there is no next page
        }
        else
        {
            return individualPageViewControllerList[indexOfCurrentPageViewController + 1]
        }
    }
    

}
