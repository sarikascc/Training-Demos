//
//  ViewController.swift
//  MapWebSplitPageViewDemo
//
//  Created by Sarika on 02/06/22.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    let webURL = URL(string: "https://www.google.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: webURL)
        webView.load(request)
        
    }
    
   
    
    @IBAction func click_onMapBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapVC")as! MapVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

