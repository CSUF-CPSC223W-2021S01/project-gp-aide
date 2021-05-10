//
//  PersonCell.swift
//  gp-aide
//
//  Created by Sergio Herrera on 5/7/21.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var personNameLbl: UILabel!
    @IBOutlet weak var matchedCoursesLbl: UILabel!
    @IBOutlet weak var personSocialLbl: UILabel!
    
    func setPerson(person: Match) {
        personNameLbl.text = person.name
        matchedCoursesLbl.text = person.matchedCourses
        personSocialLbl.text = person.social
    }
}
