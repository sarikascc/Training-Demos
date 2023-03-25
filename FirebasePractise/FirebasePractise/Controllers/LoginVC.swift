//
//  LoginVC.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 16/04/22.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginVC: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func FirebaseLogin(){
        
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            if error != nil {
                
                print("Login Error:",error!.localizedDescription)
                showAlertMsg(msg: error!.localizedDescription, view: self!)
                return
            }
            
            userID = (authResult?.user.uid)!
            print("login successfully")
            defaults.setValue(userID, forKey: UserDefaultsKeys.userID)
            defaults.setValue(1, forKey: UserDefaultsKeys.login)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "HomeNavi")as! UINavigationController
            appDelegate.window?.rootViewController = vc
            appDelegate.window?.makeKeyAndVisible()
        }
        
    }
  
    @IBAction func loginbtnclick(_ sender: Any) {
        
        if validationTextfield(textField: txtEmail, msg: "Please enter your email-Id", view: self) {
            
            if validationTextfield(textField: txtPassword, msg: "Please enter password", view: self) {
                
                FirebaseLogin()
            }
        }
       
    }
    
    
    @IBAction func click_onSignupBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignupVC")as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
