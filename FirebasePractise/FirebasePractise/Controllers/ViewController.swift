//
//  ViewController.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 25/03/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI


class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
   
   
    var db : Firestore!
    var arrDetail = [Detail]()
    
    @IBOutlet weak var table: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
//        let studentdetail = db.collection("detail")
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        
                
    }
    func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
         let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             

             if self.arrDetail[indexPath.row].url != ""{
             DataManager.shared().deleteImageFromFirebase(imgStr: self.arrDetail[indexPath.row].url)
             }
             DataManager.shared().db.collection(DBEntity.detail).document(
                self.arrDetail[indexPath.row].key).delete(){ err in
                 if let err = err {
                     print("Error removing document: \(err)")
                 } else {
                     print("Document successfully removed!")
                 }
             }
             
            
             self.arrDetail.remove(at: indexPath.row)
             self.table.deleteRows(at: [indexPath], with: .left)
             self.table.reloadData()
             success(true)
         })
         
         deleteAction.backgroundColor = .red
         
         let editAction = UIContextualAction(style: .normal, title: "edit") { (action, view, completion) in
             
             
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "passDataVC") as! passDataVC
             vc.data = self.arrDetail[indexPath.row]
             self.navigationController?.pushViewController(vc, animated: true)
           
         }
         
         return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
     }
    
    override func viewWillAppear(_ animated: Bool) {
     

        getAlldetail()        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)as!TableViewCell
        
//***************************
        
        let data = arrDetail[indexPath.row]
        
        cell.lblName.text = "name :\(data.name)"
        cell.lblAge.text = "age :\(data.age)"
        cell.lblgender.text = data.gender
        cell.marksEnglbl.text = "eng :\(data.marks["eng"]!)"
        cell.marksGujlbl.text = "guj :\(data.marks["guj"]!)"
        cell.marksScelbl.text = "sce :\(data.marks["sce"]!)"
        cell.marksHindilbl.text = "hindi :\(data.marks["hindi"]!)"

        if arrDetail[indexPath.row].url != ""{
        DataManager.shared().downloadedFrom(url: URL(string: arrDetail[indexPath.row].url)!) { image in
            cell.imageview.image = image
        }
        }
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.imageview.clipsToBounds = true
        cell.imageview.roundImg()
      
        cell.lblMarkslist.layer.borderColor = UIColor.black.cgColor;
        cell.lblMarkslist.layer.borderWidth = 4.0
        cell.lblMarkslist.clipsToBounds = true
        cell.lblMarkslist.layer.cornerRadius = 15
        cell.lblMarkslist.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        cell.lblMarkslist.backgroundColor = .green
        return cell
    }

    @IBAction func addbtnclick(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "passDataVC")as!passDataVC
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
350   }
  
    func getAlldetail(){
        DataManager.shared().getDetail { detail in
            var arrDetail1 = [Detail]()
            arrDetail1 = detail
            self.arrDetail = arrDetail1.sorted(by: {$0.time<$1.time})
            
//            self.arrDetail = detail
//            self.arrDetail.sorted(by: {$0.time>$1.time})
            
           
            print("array ::::::::",self.arrDetail)
          self.table.reloadData()
        }
    }
    
    
}

extension UIImageView{
    func roundImg(){
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.black.cgColor
      
    }
}

