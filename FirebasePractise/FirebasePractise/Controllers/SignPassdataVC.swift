//
//  SignPassdataVC.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 16/04/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth



class SignPassdataVC: UIViewController {
    
    var data : Fruits!
    
    @IBOutlet weak var txtfrt: UITextField!
    
    @IBOutlet weak var addbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if data != nil {
            
            txtfrt.text = data.name
            addbtn.setTitle("Edit", for: .normal)
        }
        else
        {
            addbtn.setTitle("Add", for: .normal)
        }
    }
   
    @IBAction func addbtnclick(_ sender: Any) {
        
        var ref = DataManager.shared().db.collection(DBEntity.fruit).document()
        
        if data != nil {
            
            ref = DataManager.shared().db.collection(DBEntity.fruit).document(data.key)
        }
        
        
        ref.setData([
            "name": txtfrt.text!,
            "created_by" : userID
        ],merge: true){ err in
            
            if let err = err {
                print("Error writing document: \(err)")
                
            } else {
                
                print("Document successfully written!")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}
