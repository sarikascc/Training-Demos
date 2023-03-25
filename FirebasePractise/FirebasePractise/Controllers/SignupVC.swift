//
//  SignupVC.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 15/04/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn


class SignupVC: UIViewController{
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPasswoprd: UITextField!
    
    var db : Firestore!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
    }
    
    func FirebaseSignUP(){
        
        let email = txtEmail.text!
        let password = txtPasswoprd.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            
            if(error != nil) {
                
                print(error!.localizedDescription)
                return
            }
            
            let user = authResult?.user
            userID = user!.uid
            let ref = db.collection("users").document(userID)
            
            let data = [
                "name":txtName.text!,
                "email" : txtEmail.text!]
            
            ref.setData(data) { Error in
                
                if error != nil {
                    
                    print("signup error:",error!.localizedDescription)
                    showAlertMsg(msg: error!.localizedDescription, view: self)
                }
                else
                {
                    defaults.setValue(1, forKey: UserDefaultsKeys.login)
                    defaults.setValue(userID, forKey: UserDefaultsKeys.userID)
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavi")as!UINavigationController
                    appDelegate.window?.rootViewController = vc
                    appDelegate.window?.makeKeyAndVisible()
                   
                }
            }
        }
        
    }
    
    @IBAction func clickonsignup(_ sender: Any) {
       
        if validationTextfield(textField: txtName, msg: "Please enter your name", view: self)
        {
            
            if validationTextfield(textField: txtEmail, msg: "Please enter email-Id", view: self) {
                
                if validationTextfield(textField: txtPasswoprd, msg: "Please enter password", view: self)
                {
                    
                    FirebaseSignUP()
                }
            }
        }
       
    }
    
    @IBAction func googlebtnclick(_ sender: Any) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if let error = error {
            print(error)
                return
            }
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
                    
            else {
              return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    
                    let user = authResult?.user
                    let name = user?.displayName
                    let email = user?.email
                    db.collection("users").document().setData([
                        "name" : name ,
                        "email" : email
                    ]){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                          
                        }
                    }
                 
                    print("Login Successful.")
                }
            }
        }
       
       
        

    }
    
    @IBAction func loginwithgooglebtnclick(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
            guard let auth = user?.authentication else { return }
            let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken!, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
               print("login with google successfully")
            }
        }
    }
}
    @IBAction func loginbtnclick(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
