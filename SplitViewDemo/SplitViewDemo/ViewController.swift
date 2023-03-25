//
//  ViewController.swift
//  SplitViewDemo
//
//  Created by Sarika scc on 03/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedRow: Int? {
        didSet {
           
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        configureView()
    }

    
    func configureView() {
       
        if let detail = selectedRow {
            switch detail {
                
            case 0 :
                self.view.backgroundColor = .red
            case 1 :
                self.view.backgroundColor = .green
            case 2 :
                self.view.backgroundColor = .yellow
            case 3 :
                self.view.backgroundColor = .orange
            case 4 :
                self.view.backgroundColor = .blue
            default:
                self.view.backgroundColor = .lightGray
            }
        }
    }

}

