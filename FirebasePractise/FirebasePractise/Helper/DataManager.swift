

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI

//var Uid = defaults.value(forKey: VHkey.UID)as! String


struct DBEntity {
    
    static let detail = "detail"
    static let student = "student"
    static let fruit = "fruit"
    static let users = "users"
}

class DataManager : NSObject {
    
    var lastdate = String()
    
    var db : Firestore!
    var listner : ListenerRegistration!
    
    override init() {
        
        self.db = Firestore.firestore()
    }
    
    
    //object allocation
    private static var sharedManager : DataManager = {
        let manager = DataManager()
        return manager
    }()
    
    class func shared() -> DataManager {
        return sharedManager
    }
    
    //MARK:- Set user data
    
//    func setUserData(uid:String,data:[String:Any]) {
//
//        db.collection(DBEntity.users).document(uid).setData(data)
//    }
//
    
    
    //MARK:- check user exist or not
    
//    func checkServiceprovider(email:String,completion:@escaping (Bool) -> Void) {
//
//        var isExist = false
//
//        db.collection(DBEntity.users).whereField("email", isEqualTo: email).getDocuments { (querySnapshot, err) in
//
//            if let err = err {
//
//                print("Error getting documents: \(err)")
//            } else {
//
//                for _ in querySnapshot!.documents {
//
//                    isExist = true
//                }
//            }
//
//            completion(isExist)
//        }
//    }
//
    
//***********  first function ***********
    
    //MARK:- Get User detail
   
    func getDetail(completion:@escaping ([Detail]) -> Void) {
        
        db.collection(DBEntity.detail).order(by: "time").getDocuments{ (querySnapshot, err) in
            
            var arrPromo = [Detail]()
            
            if let err = err {
                
                print("Error getting documents: \(err)")
            } else {
                
                let data = querySnapshot!.documents
                arrPromo = self.getdetailLimitedData(arrData: data)
                DispatchQueue.main.async {
                    
                    completion(arrPromo)
                }
            }
        }
    }
    
//************* student function
    
    func getstudent(completion:@escaping ([student]) -> Void) {
        
        db.collection(DBEntity.student).order(by: "time").getDocuments{ (querySnapshot, err) in
            
            var arrPromo = [student]()
            
            if let err = err {
                
                print("Error getting documents: \(err)")
            } else {
                
                let data = querySnapshot!.documents
                arrPromo = self.getstudentLimitedData(arrData: data)
                DispatchQueue.main.async {
                    
                    completion(arrPromo)
                }
            }
        }
    }
//************* fruit function
    
    func getfruit(id :String ,completion:@escaping ([Fruits]) -> Void) {
        
        db.collection(DBEntity.fruit).whereField("created_by", isEqualTo: id).getDocuments{ (querySnapshot, err) in
            
            var arrPromo = [Fruits]()
            
            if let err = err {
                
                print("Error getting documents: \(err)")
            } else {
                
                let data = querySnapshot!.documents
                arrPromo = self.getfruitLimitedData(arrData: data)
                DispatchQueue.main.async {
                    
                    completion(arrPromo)
                }
            }
        }
    }
    
//*********** second function **************
    
    //MARK:- Get job Candidate detail
    
   
    func getdetailLimitedData(arrData:[QueryDocumentSnapshot]) -> [Detail]{
        
        var arrPromo = [Detail]()
        
        for document in arrData {
            
            var user = Detail()
            
            user.key = document.documentID
            
            let data = document.data()
            
            if let name = data["name"] as? String {
                
                user.name = name
            }
            
            if let age = data["age"] as? String {
                
                user.age = age
            }
            
            if let gender = data["gender"] as? String {
                
                user.gender = gender
            }
            if let time = data["time"] as? Date {
                
                user.time = time
            }
            if let url = data["url"] as? String {
                
                user.url = url
            }
            if let marks = data["marks"] as? [String:Any]{
                
                user.marks = marks
            }
            arrPromo.append(user)
        }
        return arrPromo
        
    }
//   studentfuction
    
    func getstudentLimitedData(arrData:[QueryDocumentSnapshot]) -> [student]{
        
        var arrPromo = [student]()
        
        for document in arrData {
            
            var user = student()
            
            user.key = document.documentID
            
            let data = document.data()
            
            if let name = data["name"] as? String {
                
                user.name = name
            }
            
            if let stdid = data["stdid"] as? Int {
                
                user.stdid = stdid
            }
            
            if let board = data["board"] as? String {
                
                user.board = board
            }
            if let time = data["time"] as? Date {
                
                user.time = time
            }
           
            arrPromo.append(user)
        }
        return arrPromo
        
    }
    
//********* fruit function
    
    func getfruitLimitedData(arrData:[QueryDocumentSnapshot]) -> [Fruits]{
        
        var arrPromo = [Fruits]()
        
        for document in arrData {
            
            var user = Fruits()
            
            user.key = document.documentID
            
            let data = document.data()
            
            if let name = data["name"] as? String {
                
                user.name = name
            }
            if let key = data["key"] as? String {
                
                user.key = key
            }
            if let time = data["created_date"] as? Date {
                
                user.created_date = time
            }
            if let created_by = data["created_by"] as? String {
                
                user.created_by = created_by
            }

print(user)
            arrPromo.append(user)
        }
        return arrPromo
    }
    
//*********** third function *************
    
    //MARK:- Get User detail
    
    func getoneDetail(uid:String?,isReal:Bool,completion:@escaping (Detail) -> Void) {
        
        guard let u_id = uid  else { return }
        
        var user = Detail()
        
        if !isReal {
            
            db.collection(DBEntity.detail).document(u_id).getDocument{ (querySnapshot, err) in
                
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    
                    if let  data = querySnapshot?.data() {
                        
                        user = self.getDetaildata(data: data)
//                        user.key = querySnapshot!.documentID
                        
                    }
                    
                }
                completion(user)
            }
        }
        else
        {
            db.collection(DBEntity.detail).document(u_id).addSnapshotListener(includeMetadataChanges: true){ (querySnapshot, err) in
                
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    
                    if let  data = querySnapshot?.data() {
                        
                        user = self.getDetaildata(data: data)
//                        user.key = querySnapshot!.documentID
                        
                    }
                }
                completion(user)
            }
        }
    }
  
//    student fuction
    
    func getonestudent(uid:String?,isReal:Bool,completion:@escaping (student) -> Void) {
        
        guard let u_id = uid  else { return }
        
        var user = student()
        
        if !isReal {
            
            db.collection(DBEntity.student).document(u_id).getDocument{ (querySnapshot, err) in
                
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    
                    if let  data = querySnapshot?.data() {
                        
                        user = self.getstudentdata(data: data)
//                        user.key = querySnapshot!.documentID
                        
                    }
                    
                }
                completion(user)
            }
        }
        else
        {
            db.collection(DBEntity.student).document(u_id).addSnapshotListener(includeMetadataChanges: true){ (querySnapshot, err) in
                
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    
                    if let  data = querySnapshot?.data() {
                        
                        user = self.getstudentdata(data: data)
//                        user.key = querySnapshot!.documentID
                        
                    }
                }
                completion(user)
            }
        }
    }
    
//******* fruit function
    
    func getonefruit(uid:String?,isReal:Bool,completion:@escaping (Fruits) -> Void) {
        
        guard let u_id = uid  else { return }
        
        var user = Fruits()
        
        if !isReal {
            
            db.collection(DBEntity.fruit).document(u_id).getDocument{ (querySnapshot, err) in
                
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    
                    if let  data = querySnapshot?.data() {
                        
                        user = self.getfruitdata(data: data)
//                        user.key = querySnapshot!.documentID
                        
                    }
                    
                }
                completion(user)
            }
        }
        else
        {
            db.collection(DBEntity.fruit).document(u_id).addSnapshotListener(includeMetadataChanges: true){ (querySnapshot, err) in
                
                if let err = err {
                    
                    print("Error getting documents: \(err)")
                    
                } else {
                    
                    if let  data = querySnapshot?.data() {
                        
                        user = self.getfruitdata(data: data)
//                        user.key = querySnapshot!.documentID
                        
                    }
                }
                completion(user)
            }
        }
    }
    
// *************** forth function *****************

    private func getDetaildata(data:[String:Any]) -> Detail {

        var user = Detail()

        if let name = data["name"] as? String {
            
            user.name = name
        }
        
        if let age = data["age"] as? String {
            
            user.age = age
        }
        if let gender = data["gender"] as? String {
            
            user.gender = gender
        }
        if let key = data["key"] as? String {
            
            user.key = key
        }
        if let url = data["url"] as? String {
            
            user.url = url
        }
        if let time = data["time"] as? Date {
            
            user.time = time
        }
        
        if let marks = data["marks"] as? [String:Any] {
            
            user.marks = marks
        }
        return user
    }
    
//student function
    private func getstudentdata(data:[String:Any]) -> student {

        var user = student()

        if let name = data["name"] as? String {
            
            user.name = name
        }
        
        if let stdid = data["stdid"] as? Int {
            
            user.stdid = stdid
        }
        if let board = data["board"] as? String {
            
            user.board = board
        }
        if let key = data["key"] as? String {
            
            user.key = key
        }

        return user
    }
 
//********* fruit function
    
    private func getfruitdata(data:[String:Any]) -> Fruits {

        var user = Fruits()

        if let name = data["name"] as? String {
            
            user.name = name
        }
        if let key = data["key"] as? String {
            
            user.key = key
        }
        if let time = data["created_date"] as? Date {
            
            user.created_date = time
        }
        if let created_by = data["created_by"] as? String {
            
            user.created_by = created_by
        }
        
        return user
    }
    
    
    
//    *********************************************************
    //MARK:- Upload image
    
    func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        // 1
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
            return completion(nil)
        }
        
        //                guard let imageData = UIImagePNGRepresentation(image) else {
        //                    return completion(nil)
        //                }
        
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        // 2
        reference.putData(imageData, metadata: metadata, completion: { (metadata, error) in
            // 3
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // 4
            reference.downloadURL(completion: { (url, err) in
                
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                
                completion(url)
            })
        })
        
    }
    
    //MARK:- upload pdf file to firebase storage

    func uploadPDFFile(PDFFileStr: String,at reference: StorageReference,completion: @escaping (URL?) -> Void) {
        
        //    let filePath = Bundle.main.path(forResource: "mypdf", ofType: "pdf")
        
        let filePathURL = URL(fileURLWithPath: PDFFileStr)
      
        
        
    reference.putFile(from: filePathURL, metadata: nil, completion: { (metadata, error) in
            
            if let error = error {
                print("getting url error:",error.localizedDescription)
                return completion(nil)
            }
            
            reference.downloadURL (completion: { (url, err) in
                if let error = error {
                    print("getting download url error:",error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }
    
    
   
    
    //MARK:- download images from Url
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit,completion:@escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            
            else {  return }
            DispatchQueue.main.async() { () -> Void in
                
                if image == nil {
                    
                    completion(nil)
                }
                else
                {
                    completion(image)
                }
                
            }
        }.resume()
    }
    
// delete image from firebase
    
    func deleteImageFromFirebase(imgStr: String){
            
            Storage.storage().reference(forURL: imgStr).delete { (error) in
                
                if error == nil {
                    
                    print("Image Deleted")
                }
            }
        }
  
}





