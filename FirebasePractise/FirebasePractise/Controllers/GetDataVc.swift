//
//  GetDataVc.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 28/03/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage


class GetDataVc: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var data = student()
    var db : Firestore!
    var board : String = ""
    var img = UIImage()
    @IBOutlet weak var txtfdid: UITextField!
    @IBOutlet weak var txtfdname: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var btn12: UIButton!
    @IBOutlet weak var btn10: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        if data.name != ""{
            addbtn.setTitle("update", for: .normal)
            txtfdname.text = data.name
            txtfdid.text = "\(data.stdid)"
        }
        else{
            addbtn.setTitle("add", for: .normal)
        }
    }
    
    @IBAction func std12btnclick(_ sender: Any) {
        btn10.setTitleColor(UIColor.black, for: .normal)
        btn12.setTitleColor(UIColor.blue, for: .normal)
       board = "h.s.c"
        
    }
    
    @IBAction func std10click(_ sender: Any) {
        btn10.setTitleColor(UIColor.blue, for: .normal)
        btn12.setTitleColor(UIColor.black, for: .normal)
      board = "s.s.c"
    }
    
    @IBAction func addbtnclick(_ sender: Any) {
        
        if data.name != "" {
            let ref = DataManager.shared().db.collection(DBEntity.student).document(data.key)
           ref.updateData([

                "name": txtfdname.text!,
                "stdid": Int(txtfdid.text!),
                "board": board,
                "time" : Date(),
                "key" : ref.documentID
                
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                    self.navigationController?.popViewController(animated: true)
                }
            }
           
        }
        
        else{
            let fileName = "\(NSDate().timeIntervalSince1970).jpg"
            let imageRef = Storage.storage().reference(withPath: "Ordered").child(fileName)
            print("Image:::",fileName)
            DataManager.shared().uploadImage(img, at: imageRef) { [self] url in
            
                let ref = DataManager.shared().db.collection(DBEntity.student).document()
                ref.setData([
                    "key":ref.documentID,
                    "name": txtfdname.text!,
                    "stdid":Int(txtfdid.text!),
                    "board" : board,
                    "time" : Date(),
                    "image" : url?.absoluteString
                    
                ]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            
        
           
    }
        
    }
    
    @IBAction func imageBtnclick(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
               imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
           }

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        imageview.image = info[.originalImage] as! UIImage
        img = info[.originalImage] as! UIImage
     
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
