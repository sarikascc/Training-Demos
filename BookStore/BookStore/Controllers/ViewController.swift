//
//  ViewController.swift
//  BookStore
//
//  Created by Sarika on 22/03/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lbl_notFound: UILabel!
    @IBOutlet weak var tblView_book: UITableView!
    var refreshControl  = UIRefreshControl()
    var arrTblBooks = [Tbl_Books]()
    
    var context : NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        self.refreshControl.addTarget(self, action: #selector(pullToRefreshTbl), for: UIControl.Event.valueChanged)
        self.tblView_book.addSubview(refreshControl)
        // Do any additional setup after loading the view.
        getBookRecords()
    }
    
    @objc func pullToRefreshTbl(){
        
        getBookRecords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        getBookRecords()
    }
        
    func getBookRecords(){
        
        arrTblBooks.removeAll()
        self.refreshControl.endRefreshing()
        
        let fetchReq :NSFetchRequest<Tbl_Books>
        fetchReq = Tbl_Books.fetchRequest()

        do{
            let array = try context.fetch(fetchReq)
            arrTblBooks = array
            print("Books:",arrTblBooks.count)
            print("Books:",arrTblBooks)
            
            tblView_book.reloadData()
            lbl_notFound.isHidden  = arrTblBooks.count > 0
        }
        catch
        {
            print("Could not load save data: \(error.localizedDescription)")
        }
        
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
        
        if let imageData = UIImage(contentsOfFile: imagePath) {
            return imageData
        } else {
            print("UIImage could not be created.")
            
            return nil
        }
    }

    
    //MARK: tableview delegate method

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return arrBooks.count
        return arrTblBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTblCell", for: indexPath)as! BookTblCell
        
        cell.bg_view.setShadoCell()
        cell.bg_view.cornerRadius = 10
        
        let data = arrTblBooks[indexPath.row]
        cell.lbl_bookNme.text = data.book_name
        cell.lbl_authorName.text = data.author_name
        cell.lbl_description.text = data.book_desc

        cell.img_book.cornerRadius = 10
        let arrImg = data.book_images?.allObjects as! [Tbl_Images]
        print("imgadta:",arrImg[0].img_url ?? "")
        cell.img_book.image = fetchImage(imageName: arrImg[0].img_url!)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completion) in
            
            let alertVC = UIAlertController(title: "Delete", message: "Are you sure you want to delete this book?", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            alertVC.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                
                let data = self.arrTblBooks[indexPath.row]
                
                let fetchReq :NSFetchRequest<Tbl_Books>
                fetchReq = Tbl_Books.fetchRequest()
                fetchReq.predicate =  NSPredicate(format: "book_id == %@", data.book_id!)
                let getdata = try? self.context.fetch(fetchReq)
                
                self.context.delete(getdata![0])
                self.arrTblBooks.remove(at: indexPath.row)
                self.tblView_book.deleteRows(at: [indexPath], with: .fade)
                
                do{
                    try self.context.save()
                }
                catch
                {
                    print(error)
                }
            }))
            
           
            self.present(alertVC, animated: true, completion: nil)
            
          
            completion(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "edit") { (action, view, completion) in
            
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddBookVC") as! AddBookVC
            vc.bookData = self.arrTblBooks[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
            completion(true)
        }
        
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        
    }
    
    @IBAction func click_onAddBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddBookVC")as! AddBookVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

