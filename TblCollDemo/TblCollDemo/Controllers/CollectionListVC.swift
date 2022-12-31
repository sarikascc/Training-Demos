//
//  CollectionListVC.swift
//  TblCollDemo
//
//  Created by Sarika on 01/06/22.
//

import UIKit

class CollectionListVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var coll_list: UICollectionView!
    var arrList = [ListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Collection List"
        setDataToList()
        coll_list.delegate = self
        coll_list.dataSource = self
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        layout.itemSize = CGSize(width: coll_list.frame.size.width / 2 - 5 , height: 185)
//        coll_list.collectionViewLayout = layout
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
        
        coll_list.reloadData()
    }
    
    func setShadoCell(view:UIView) {
        
        let layer = view.layer
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
    
    
    //MARK: collectionview delegate method
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            
            headerView.backgroundColor = UIColor.white
            
            let label = UILabel(frame: CGRect(x: 15, y: 10, width: headerView.frame.size.width, height: 30))
            label.text = "Companies"
            label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            headerView.addSubview(label)
            
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            let label = UILabel(frame: CGRect(x: 15, y: 10, width: footerView.frame.size.width, height: 30))
            label.text = "Footer Details"
            label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            footerView.addSubview(label)
            
            footerView.backgroundColor = UIColor.white
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollCell", for: indexPath)as! ListCollCell
        let data = arrList[indexPath.row]
        cell.lbl_title.text = data.title
        cell.lbl_address.text = data.address
        cell.img.backgroundColor = .orange.withAlphaComponent(0.5)
        cell.img.layer.cornerRadius = 10
        cell.bg_view.layer.cornerRadius = 10
        
        
        setShadoCell(view: cell.bg_view)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC")as! DetailVC
        vc.listData = arrList[indexPath.row]
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: coll_list.frame.size.width / 2 - 5 , height: 185)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil"), identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                print("edit button clicked")
            }
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil,attributes: .destructive, state: .off) { (_) in
                
                self.arrList.remove(at: indexPath.row)
                self.coll_list.deleteItems(at: [indexPath])
                print("delete button clicked")
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [edit,delete])
            
        }
        
        return context
        
    }
    
    //MARK: Click Events
    
    @IBAction func click_onRefreshBtn(_ sender: Any) {
        
        setDataToList()
    }
    
}
