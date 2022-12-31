//
//  ListTblCell.swift
//  TblCollDemo
//
//  Created by Sarika on 01/06/22.
//

import UIKit

class ListTblCell: UITableViewCell {

    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bg_View: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
