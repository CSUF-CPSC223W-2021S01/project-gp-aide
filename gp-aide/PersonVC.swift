//
//  PersonVC.swift
//  gp-aide
//
//  Created by Sergio Herrera on 5/7/21.
//

import UIKit

class PersonVC: UIViewController {

    // classmates is pool of all classmates
    let classmates = TEST_CLASSMATES
    // userCourses are all courses user has added to term
    let userCourses: [String] = USER_COURSES
    
    // matches initially empty
    // but stores dictionary of matched classmates with classes they matched with
    var matches: [String] = ["EthanThatOneKid", "SamuelThatOneKid", "SergioThatOneKid", "JacobThatOneKid"]
    
    @IBOutlet weak var personView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("in PersonVC")
        
        // NEED TO IMPLEMENT
        // algorithm to add matched classmates using courses
        /*
            for classmate in CLASSMATES
                matchedCourses = []
                for course in classmate's courses
                    for userCourse in user's courses
                        if courses are a match
                            add course to matchedCourses
                if matchedCourses is not empty
                    add classmate and matchedCourses array to data array
         */
        
        personView.dataSource = self
    }
}

extension PersonVC: UITableViewDataSource {
    
    // number of persons to display for entire section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    // assign data to display in each cell
    // NEED TO IMPLEMENT
    // need to map name and courses labels to each matched classmate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create cell to add data to
        let cell = personView.dequeueReusableCell(withIdentifier: "personCell") as! PersonCell
        // create person to add to cell
        let person = matches[indexPath.row]
        // assign person to name label in created cell
        cell.personNameLbl.text = person
        
        return cell
    }
    
}