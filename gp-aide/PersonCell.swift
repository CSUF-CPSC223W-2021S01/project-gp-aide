//
//  PersonCell.swift
//  gp-aide
//
//  Created by CSUFTitan on 5/7/21.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var personNameLbl: UILabel!
    @IBOutlet weak var matchedCoursesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
