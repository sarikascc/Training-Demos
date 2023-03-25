//
//  passDataVC.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 25/03/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI
class passDataVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var flag = 0
    var db : Firestore!
    var data  = Detail()
    var gender : String = ""
    var image = UIImage()
    
    @IBOutlet weak var imageviewTap: UIImageView!
    @IBOutlet weak var txtfdSce: UITextField!
    @IBOutlet weak var txtfdEng: UITextField!
    @IBOutlet weak var txtfdHindi: UITextField!
    @IBOutlet weak var txtfdguj: UITextField!
    @IBOutlet weak var marksLbl: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var femalebtn: UIButton!
    @IBOutlet weak var malebtn: UIButton!
    @IBOutlet weak var ageTxtfd: UITextField!
    @IBOutlet weak var nameTxtfd: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        imageview.roundImg()
        gender = data.gender
        
        imageviewTap.layer.borderColor = UIColor.black.cgColor;
        imageviewTap.layer.borderWidth = 4.0
        imageviewTap.clipsToBounds = true
        imageviewTap.layer.cornerRadius = 15
      let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender: )))
        imageviewTap.addGestureRecognizer(tap)
        imageviewTap.isUserInteractionEnabled = true
        
        nameTxtfd.layer.borderWidth = 2
        nameTxtfd.layer.borderColor = UIColor(red: 48, green: 176, blue: 199).cgColor
        ageTxtfd.layer.borderWidth = 2
        ageTxtfd.layer.borderColor = UIColor(red: 48, green: 176, blue: 199).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if data.name != ""{
            addbtn.setTitle("update", for: .normal)
            marksLbl.text = "editMarks"
            nameTxtfd.text = data.name
            ageTxtfd.text = data.age
            txtfdguj.text = "\(data.marks["guj"]!)"
            txtfdSce.text = "\(data.marks["sce"]!)"
            txtfdEng.text = "\(data.marks["eng"]!)"
            txtfdHindi.text = "\(data.marks["hindi"]!)"
            
            DataManager.shared().downloadedFrom(url: URL(string: data.url)!) { image in
                self.imageview.image = image
            }
          
        }
        else{
            addbtn.setTitle("add", for: .normal)
            marksLbl.text = "enterMarks"
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            var imagepicker = UIImagePickerController()
            imagepicker.delegate = self
            imagepicker.sourceType = .photoLibrary;
            imagepicker.allowsEditing = true
            imagepicker.view.tag = 1
            self.present(imagepicker, animated: true, completion: nil)

        }
    }

    
    @IBAction func malebtnclick(_ sender: Any) {
        
        femalebtn.setTitleColor(UIColor.black, for: .normal)
        malebtn.setTitleColor(UIColor.blue, for: .normal)
        gender = "male"
    }
    
    @IBAction func femalebtnclick(_ sender: Any) {
        malebtn.setTitleColor(UIColor.black, for: .normal)
        femalebtn.setTitleColor(UIColor.blue, for: .normal)
        gender = "female"
    }
    @IBAction func addbtnclick(_ sender: Any) {
        
        if data.name != "" {
            if flag == 1 {
            let filename = "\(NSDate().timeIntervalSince1970).jpg"
            let imageref = Storage.storage().reference(withPath: "store").child(filename)
         DataManager.shared().uploadImage(image, at: imageref) { url in
             self.updatedata(data1: url!)
            }
            }
            else{
                updatedata(data1: URL(string: data.url)!)
            }
           
        }
        else{
           
            let filename = "\(NSDate().timeIntervalSince1970).jpg"
            let imageref = Storage.storage().reference(withPath: "detailimage").child(filename)
            DataManager.shared().uploadImage(image, at: imageref) { url in
                let ref = DataManager.shared().db.collection(DBEntity.detail).document()
         
                ref.setData([
                    "key":ref.documentID,
                    "name": self.nameTxtfd.text!,
                    "age": self.ageTxtfd.text!,
                    "gender" : self.gender,
                    "time" : Date(),
                    "url" : url?.absoluteString,
                    "marks" : [ "guj":self.txtfdguj.text,"eng":self.txtfdEng.text,"sce":self.txtfdSce.text,"hindi":self.txtfdHindi.text]
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
    func updatedata(data1:URL) {
        let ref = DataManager.shared().db.collection(DBEntity.detail).document(self.data.key)
       ref.updateData([

        "name": self.nameTxtfd.text!,
        "age": self.ageTxtfd.text!,
        "gender": self.gender,
       "url" : data1.absoluteString,
        "marks" : [ "guj" :txtfdguj.text,"eng":txtfdEng.text,"sce":txtfdSce.text,"hindi":txtfdHindi.text]
        ])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    @IBAction func pickimage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            var imagepicker = UIImagePickerController()
            imagepicker.delegate = self
            imagepicker.sourceType = .photoLibrary;
            imagepicker.allowsEditing = true
            imagepicker.view.tag = 0
            self.present(imagepicker, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.view.tag == 0{
        imageview.image = info[.originalImage]as!UIImage
        image = info[.originalImage] as! UIImage
       flag = 1
        }
        else if picker.view.tag == 1 {
            imageviewTap.image = info[.originalImage]as!UIImage}
            
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
