//
//  segmentVC.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 29/03/22.
//

import UIKit

class segmentVC: UIViewController {

   
    @IBOutlet weak var thirdview: UIView!
    @IBOutlet weak var secondview: UIView!
    @IBOutlet weak var firstview: UIView!
   
    @IBOutlet weak var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        secondview.isHidden = true
        thirdview.isHidden = true
        segment.layer.borderWidth = 2
      
    }
    

    @IBAction func segmentTap(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            print("1")
            secondview.isHidden = true
            thirdview.isHidden = true
            firstview.isHidden = false
            
        }else if sender.selectedSegmentIndex == 1 {
            print("2")
            firstview.isHidden = true
            thirdview.isHidden = true
            secondview.isHidden = false
        }
        else{
            print("3")
            secondview.isHidden = true
            firstview.isHidden = true
            thirdview.isHidden = false
        }
    }
    

}
