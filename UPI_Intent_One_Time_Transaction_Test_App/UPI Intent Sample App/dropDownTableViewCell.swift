//
//  dropDownTableViewCell.swift
//  UPI Intent Sample App
//
//  Created by Vishrut tewatia on 28/02/24.
//

import UIKit

class dropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var reasonLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(label: String) {
        self.reasonLbl.text = label
    }
    
}
