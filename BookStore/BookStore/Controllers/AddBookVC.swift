//
//  AddBookVC.swift
//  BookStore
//
//  Created by Sarika on 25/03/22.
//

import UIKit
import CoreData



class AddBookVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
   
    @IBOutlet var TFViews: [UIView]!
    
    @IBOutlet var txts: [UITextField]!
    
    @IBOutlet weak var txt_desc: UITextView!
    @IBOutlet weak var btn_save: UIButton!
    @IBOutlet weak var coll_books: UICollectionView!
    
    
    var arrImages = [String]()
    var arrUpdatedImages = [String]()
    var arrRemoveImages = [String]()
    let imagepicker = UIImagePickerController()
    var selectedIndex = -1
    
    var bookData:Tbl_Books!
    
    var context : NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txts.forEach({$0.delegate = self})
        txt_desc.delegate = self
        TFViews.forEach({$0.setBorder(1, color: appThemeColor!, CR: 10)})
        btn_save.cornerRadius = 10
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tapOnBgView))
        tapgesture.numberOfTapsRequired = 2
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapgesture)
        
        if bookData != nil {
            
            setUpdatedData()
            btn_save.setTitle("Update", for: .normal)
        }

    }
    
    func setUpdatedData(){
        
        txts[0].text = bookData.book_name!
        txts[1].text = bookData.author_name!
        txt_desc.text = bookData.book_desc!
        
        let arrImgs = bookData.book_images?.allObjects as! [Tbl_Images]
        for (i,obj) in arrImgs.enumerated() {
            
            arrImages.append(obj.img_url!)
            
            if i == arrImgs.count - 1 {
                
                coll_books.reloadData()
            }
        }
       
        
    }
    
    @objc func tapOnBgView(sender:UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    func addBookRecord(){
        
        let bookData = Tbl_Books(context: context)
        bookData.book_name = txts[0].text!
        bookData.author_name = txts[1].text!
        bookData.book_desc = txt_desc.text!
        bookData.book_id = bookData.objectID.uriRepresentation().absoluteString
        
        for (i,obj) in arrImages.enumerated() {
           
            let imgData = Tbl_Images(context:context)
            imgData.img_url = obj
            imgData.b_id = bookData.objectID.uriRepresentation().absoluteString
            imgData.image_id = imgData.objectID.uriRepresentation().absoluteString
            bookData.addToBook_images(imgData)
          
            if i == arrImages.count - 1 {
                
                do
                {
                    try context.save()
                    showAlertWithMsg(msg: "Book Added SuccessFully!", cc: self)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.navigationController?.popViewController(animated: true)
                    }
                   
                }
                catch
                {
                    print("saving error:",error.localizedDescription)
                    
                }
            }
        }        
    }
    
    func updateBookRecord(){
        
        let fetchReq :NSFetchRequest<Tbl_Books>
        fetchReq = Tbl_Books.fetchRequest()
        fetchReq.predicate =  NSPredicate(format: "book_id == %@", bookData.book_id!)
        
        let getData = try? self.context.fetch(fetchReq)
        
        let bookData = getData![0]
        bookData.book_name = txts[0].text!
        bookData.author_name = txts[1].text!
        bookData.book_desc = txt_desc.text!
        bookData.book_id = bookData.objectID.uriRepresentation().absoluteString
        
        if arrUpdatedImages.count > 0 {
            
            for (i,obj) in arrUpdatedImages.enumerated() {
                
                let imgData = Tbl_Images(context:context)
                imgData.img_url = obj
                imgData.b_id = bookData.objectID.uriRepresentation().absoluteString
                imgData.image_id = imgData.objectID.uriRepresentation().absoluteString
                bookData.addToBook_images(imgData)
                
                if i == arrUpdatedImages.count - 1 {
                    
                    saveAndGoBack()
                }
            }
        }
        else
        {
            saveAndGoBack()
        }
    }
    
    func saveAndGoBack(){
        
        for obj in arrRemoveImages
        {
            let fetchReq :NSFetchRequest<Tbl_Images>
            fetchReq = Tbl_Images.fetchRequest()
            fetchReq.predicate =  NSPredicate(format: "img_url == %@", obj)
            
            let getData = try? self.context.fetch(fetchReq)
            if getData?.count != 0 {
                
                let imgData = getData![0]
                context.delete(imgData)
                bookData.removeFromBook_images(imgData)
                do {
                    
                    try self.context.save()
                }
                catch{}
            }
        }
        
        
        do
        {
            try context.save()
            showAlertWithMsg(msg: "Book Updated SuccessFully!", cc: self)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        catch
        {
            print("updating error:",error.localizedDescription)
        }
        
    }
  
    //MARK: collectionview delegate method
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row != arrImages.count {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookImgCell", for: indexPath)as! BookImgCell
            cell.bg_view.cornerRadius = 10
            cell.bg_view.setShadoCell()
            cell.img_book.cornerRadius = 10
            cell.btn_delete.backgroundColor = .white
            cell.btn_delete.setBorder(1, color: .white, CR: cell.btn_delete.frame.size
                                        .height / 2)
            
            cell.img_book.image = fetchImage(imageName: arrImages[indexPath.row])
            
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(Click_onDeleteBtn), for: .touchUpInside)
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookAddCollCell", for: indexPath)as! BookAddCollCell
            cell.bg_view.cornerRadius = 10
            cell.bg_view.setShadoCell()
          
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == arrImages.count {
            
            imagepicker.sourceType = .photoLibrary
            imagepicker.delegate = self
            self.present(imagepicker, animated: true, completion: nil)
        }
    }
    
    @objc func Click_onDeleteBtn(sender:UIButton) {
        
        let index = sender.tag
        if let img_index = arrUpdatedImages.firstIndex(of: arrImages[index]) {
            
            self.arrUpdatedImages.remove(at: img_index)
        }
        self.arrRemoveImages.append(arrImages[index])
        arrImages.remove(at: index)
        coll_books.reloadData()
    }
  
    
    //MARK: imagepicker controller delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imgName = saveImage(image: info[.originalImage]as! UIImage)!
        arrImages.append(imgName)
        
        if bookData != nil {
            
            arrUpdatedImages.append(imgName)
        }
        coll_books.reloadData()
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveImage(image: UIImage) -> String? {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let timestamp = NSDate().timeIntervalSince1970
        let fileName = "\(timestamp).jpg"
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        
        if let data = image.jpegData(compressionQuality:  1.0),
           !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print(fileURL.path)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
        debugPrint(fileName.description)
        return fileName
        
    }
    
    func fetchImage(imageName: String) -> UIImage? {
        
        print("fetch image",imageName)
        let fileManager = FileManager.default
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imagePath = documentsPath.appendingPathComponent(imageName).path
        
        guard fileManager.fileExists(atPath: imagePath) else {
            print("Image does not exist at path: \(imagePath)")
            return nil
        }
        
        if let image = UIImage(contentsOfFile: imagePath) {
            return image
        } else {
            print("UIImage could not be created.")
            
            return nil
        }
    }
    
    //MARK: textfield delegate method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func click_onBackBtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func click_onSaveBtn(_ sender: Any) {
        
        if arrImages.count != 0 {
            
            if validationTextField(txt: txts[0], msg: "Please add book name", cc: self) {
                
                if validationTextField(txt: txts[1], msg: "Please add author name", cc: self) {
                    
                    if txt_desc.text != "" {
                        
                        if bookData != nil {
                            
                            updateBookRecord()
                        }
                        else
                        {
                            addBookRecord()
                        }
                    }
                    else
                    {
                        showAlertWithMsg(msg: "Please add book description", cc: self)
                    }
                }
            }
        }
        else
        {
            showAlertWithMsg(msg: "Please enter at leat one image of book", cc: self)
        }
        
    }
}
