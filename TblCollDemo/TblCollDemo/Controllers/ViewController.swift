//
//  ViewController.swift
//  TblCollDemo
//
//  Created by Sarika on 01/06/22.
//

import UIKit

struct ListData{
    
    var title : String
    var address : String
    
    init(title:String,address:String){
        
        self.title = title
        self.address = address
    }
}



class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    

    @IBOutlet weak var tbl_list: UITableView!
    
    @IBOutlet weak var btn_edit: UIBarButtonItem!
    var arrList = [ListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataToList()
        
        tbl_list.delegate = self
        tbl_list.dataSource = self
        // Do any additional setup after loading the view.
        
        tbl_list.sectionHeaderTopPadding = 0
    }
    
    func setDataToList(){
        
        arrList = [ListData(title: "Scc Infotech", address: "sarthana"),
                   ListData(title: "Riseup", address: "Jakatnaka"),
                   ListData(title: "Infosys", address: "Surat"),
                   ListData(title: "TCS", address: "Bangalore"),
                   ListData(title: "Switchcase", address: "Katargam"),
                   ListData(title: "Origin", address: "Amroli"),
                   ListData(title: "Grewon", address: "Adajan"),
                   ListData(title: "Prakshal", address: "Adajan")]
        
        tbl_list.reloadData()
    }
    
    func setShadoCell(view:UIView) {
        
        let layer = view.layer
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
    
    //MARK: tableview delegate method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tbl_list.frame.size.width, height: 40))
        headerView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: headerView.frame.size.width, height: 30))
        label.text = "Companies"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        headerView.addSubview(label)
        
        return headerView
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTblCell", for: indexPath)as! ListTblCell
        
        let data = arrList[indexPath.row]
        cell.lbl_title.text = data.title
        cell.lbl_address.text = data.address
        cell.img.backgroundColor = .lightGray
        cell.img.layer.cornerRadius = 10
        cell.bg_View.layer.cornerRadius = 10
        
        setShadoCell(view: cell.bg_View)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC")as! DetailVC
        vc.listData = arrList[indexPath.row]
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tbl_list.frame.size.width, height: 40))
        footerView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: footerView.frame.size.width, height: 30))
        label.text = "Footer Details"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        footerView.addSubview(label)
        
        return footerView
    }
    
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = arrList[sourceIndexPath.row]
        arrList.remove(at: sourceIndexPath.row)
        arrList.insert(itemToMove, at: destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            arrList.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView,
                    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Edit btn")
            success(true)
        })
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }

     func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .normal, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.arrList.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
            success(true)
        })
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        
        let moreAction = UIContextualAction(style: .normal, title:  "More", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            print("More Btn")
            success(true)
        })
        moreAction.backgroundColor = .lightGray
        
        return UISwipeActionsConfiguration(actions: [moreAction,deleteAction])
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), identifier: nil, discoverabilityTitle: "", attributes: UIMenuElement.Attributes.destructive) { action in
                
                self.arrList.remove(at: indexPath.row)
                self.tbl_list.deleteRows(at: [indexPath], with: .automatic)
                
            }
            
            return UIMenu(title: "", children: [deleteAction])
        }
    }
    
    //MARK: Click Events

    @IBAction func click_onCollectionList(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionListVC")as! CollectionListVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func click_onEditTableBtn(_ sender: Any) {
        
        tbl_list.isEditing = !tbl_list.isEditing
        btn_edit.title = tbl_list.isEditing ? "Done" : "Edit"
        
    }
    
    
    @IBAction func click_onRefreshBtn(_ sender: Any) {
        
        setDataToList()
    }
    
    
}

