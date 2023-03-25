//
//  AddBookVC.swift
//  Demp App
//
//  Created by Sarika scc on 23/12/22.
//

import UIKit

class SignUPVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func click_onClosebtb(_ sender: Any) {
        
//        self.dismiss(animated: true, completion: nil)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
