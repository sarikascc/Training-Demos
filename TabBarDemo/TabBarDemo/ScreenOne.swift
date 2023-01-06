//
//  ViewController.swift
//  TabBarDemo
//
//  Created by Sarika scc on 06/01/23.
//

import UIKit

class ScreenOne: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func click_onPushBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC")as! DetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

