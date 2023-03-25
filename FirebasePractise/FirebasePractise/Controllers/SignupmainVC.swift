//
//  SignupmainVC.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 16/04/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth


class SignupmainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrfruit = [Fruits]()
    var db : Firestore!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        table.delegate = self
        table.dataSource = self
        getProfileDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getfruitdetail()
    }
    
    func getProfileDetail(){
        
        db.collection("users").document(userID).getDocument{ (querySnapshot, err) in
            
            if let err = err {
                
                print("Error getting documents: \(err)")
                
            } else {
                
                if let data = querySnapshot?.data() {
                    
                    var user = User()
                    
                    user.key = querySnapshot!.documentID
                    
                    if let name = data["name"] as? String {
                        
                        user.name = name
                    }
                    
                    if let email = data["email"] as? String {
                        
                        user.email = email
                    }
                    
                    print("userData:",user)
                    
                }
                
            }
            
        }
    }
    
    func getfruitdetail(){
        
        DataManager.shared().getfruit(id: userID) {  Fruit in
            
            self.arrfruit = Fruit
            
            print("arrr::::::::",self.arrfruit)
            self.table.reloadData()
        }
    }
    
    @IBAction func addbtnclick(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignPassdataVC") as! SignPassdataVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: tableview delegate method
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        arrfruit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "signuptblviewcell"   )as!signuptblviewcell
        
        cell.lblfrt.text = arrfruit[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            DataManager.shared().db.collection(DBEntity.fruit).document(
                self.arrfruit[indexPath.row].key).delete(){ err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            
            
            self.arrfruit.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .left)
            success(true)
        })
        
        deleteAction.backgroundColor = .red
        let editAction = UIContextualAction(style: .normal, title: "edit") { (action, view, completion) in
            
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignPassdataVC") as! SignPassdataVC
            vc.data = self.arrfruit[indexPath.row]
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
    }
    
    
    
    @IBAction func click_onLogoutBtn(_ sender: Any) {
        
        
        defaults.removeObject(forKey: UserDefaultsKeys.login)
        defaults.removeObject(forKey: UserDefaultsKeys.userID)
        
        do {

            try Auth.auth().signOut()
          
        }
        catch
        {
            print("logout error:",error.localizedDescription)
        }
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavi")as!UINavigationController
        appDelegate.window?.rootViewController = vc
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
}
