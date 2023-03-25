//
//  Constant.swift
//  FirebasePractise
//
//  Created by Sarika on 22/06/22.
//

import Foundation
import UIKit

let defaults = UserDefaults.standard
var userID = defaults.value(forKey: UserDefaultsKeys.userID) as? String ?? "1234"

struct UserDefaultsKeys {
    
    static let userID : String = "userID"
    static let login : String = "login"

}

func validationTextfield(textField:UITextField,msg:String,view:UIViewController) -> Bool {
    
    if textField.text != "" {
        
        return true
    }
    else
    {
        showAlertMsg(msg: msg, view: view)
        return false
    }
    
}

func showAlertMsg(msg:String,view:UIViewController) {
    
    let alertVC = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    
    DispatchQueue.main.async {
        
        view.present(alertVC, animated: true, completion: nil)
    }
    
}
