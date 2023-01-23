//
//  BookTblCell.swift
//  BookStore
//
//  Created by Sarika on 24/03/22.
//

import UIKit

class BookTblCell: UITableViewCell {

    @IBOutlet weak var bg_view: UIView!
    @IBOutlet weak var lbl_authorName: UILabel!
    @IBOutlet weak var lbl_bookNme: UILabel!
    @IBOutlet weak var img_book: UIImageView!
    
    @IBOutlet weak var lbl_description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
