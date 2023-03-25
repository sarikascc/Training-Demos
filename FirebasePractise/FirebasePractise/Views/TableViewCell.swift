//
//  TableViewCell.swift
//  FirebasePractise
//
//  Created by Rutika Scc on 25/03/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    
    @IBOutlet weak var lblMarkslist: UILabel!
    @IBOutlet weak var marksEnglbl: UILabel!
    
    @IBOutlet weak var marksHindilbl: UILabel!
    @IBOutlet weak var marksScelbl: UILabel!
    @IBOutlet weak var marksGujlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
