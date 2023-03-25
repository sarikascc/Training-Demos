//
//  MainDataVc.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 28/03/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct student{
    
   var name: String
    var stdid : Int
    var key :String
    var time : Date
    var board : String
   
    init(){
       name = ""
       stdid = 0
       key = ""
       time = Date()
       board = ""
    }
    
}



class MainDataVc: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var Table: UITableView!
    var arrstudent = [student]()
    
    var db : Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        db = Firestore.firestore()
        Table.dataSource = self
        Table.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrivealldata()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrstudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table.dequeueReusableCell(withIdentifier: "maindataTblViewCell", for: indexPath)as!maindataTblViewCell
        cell.lblName.text = "name : \(arrstudent[indexPath.row].name)"
        cell.lblid.text = "\(arrstudent[indexPath.row].stdid)"
        cell.lblstd.text = "board : \(arrstudent[indexPath.row].board)"
        
    return cell
    }
   
    @IBAction func addbtnclick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GetDataVc") as! GetDataVc
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
         let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             
             DataManager.shared().db.collection(DBEntity.student).document(self.arrstudent[indexPath.row].key).delete(){ err in
                 if let err = err {
                     print("Error removing document: \(err)")
                 } else {
                     print("Document successfully removed!")
                 }
             }
            
            
             self.arrstudent.remove(at: indexPath.row)
             self.Table.deleteRows(at: [indexPath], with: .fade)
             self.Table.reloadData()
             success(true)
         })
         deleteAction.backgroundColor = .red
         
         let editAction = UIContextualAction(style: .normal, title: "edit") { (action, view, completion) in
             
             
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetDataVc") as! GetDataVc
             vc.data = self.arrstudent[indexPath.row]
             self.navigationController?.pushViewController(vc, animated: true)
             
             completion(true)
         }
         
         return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func retrivealldata(){
        
        DataManager.shared().getstudent { student in
            self.arrstudent = student
            self.Table.reloadData()
        }
    }
}
