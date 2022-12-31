//
//  TableViewCell.swift
//  ApiDemo
//
//  Created by Rutika Scc on 04/04/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
