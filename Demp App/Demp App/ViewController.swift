//
//  ViewController.swift
//  Demp App
//
//  Created by Sarika scc on 23/12/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tbl_fruits: UITableView!
    var arrName : [String] = []
    
    var arrFruits = ["Mango","Apple","Graps","Bananas","Pineapple","Strawberry"]
    var arrRollNo = [6,1,2,3,4,5]
    var arrDic = [String:Any]()
    var selectedItem = -1
    var arrSelectedItems = [Int]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tbl_fruits.delegate = self
        tbl_fruits.dataSource = self
        tbl_fruits.register(UITableViewCell.self, forCellReuseIdentifier: "FruitsTblCell")
       
    }
    
    //MARK: tableview methods

    func numberOfSections(in tableView: UITableView) -> Int {

        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FruitsTblCell", for: indexPath)
        cell.textLabel?.text = arrFruits[indexPath.row]
       
        
//        if selectedItem == indexPath.row {
//
//            print("cell selected indexPath.row:",indexPath.row)
//            cell.imageView?.image = UIImage(systemName: "circle.fill")
//        }
//        else
//        {
//            cell.imageView?.image = UIImage(systemName: "circle")
//        }
        
        if arrSelectedItems.contains(indexPath.row){
            
            print("cell selected indexPath.row:",indexPath.row)
            cell.imageView?.image = UIImage(systemName: "circle.fill")
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.imageView?.image = UIImage(systemName: "circle")
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print("selected indexPath.row:",indexPath.row)
//        selectedItem = indexPath.row
        
        if let index = arrSelectedItems.firstIndex(of: indexPath.row){
            
            arrSelectedItems.remove(at: index)
            print("selected index:",index)
            print("selected indexpath.row:",indexPath.row)
        }
        else
        {
            arrSelectedItems.append(indexPath.row)
        }
        
        print("selected indexPath.row:",arrSelectedItems)
        tbl_fruits.reloadData()
    }
    
}
