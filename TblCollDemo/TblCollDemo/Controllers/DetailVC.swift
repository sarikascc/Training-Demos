//
//  DetailVC.swift
//  TblCollDemo
//
//  Created by Sarika on 01/06/22.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var lbl_title: UILabel!
    var listData: ListData!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Data:",listData!)
        lbl_title.text = listData.title
    }
    
}
