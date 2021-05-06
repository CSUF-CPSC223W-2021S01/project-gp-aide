//
//  PeopleViewController.swift
//  gp-aide
//
//  Created by Sergio Herrera on 5/4/21.
//

import UIKit

class PeopleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var matchedCoursesLbl: UILabel!
    
    // table data to display in People Screen
    var tableData: [String] = []
    
    // list of courses for current term
    // var courses: [String] = []
    let classmates = TEST_CLASSMATES
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ALGORITHM TO ADD MATCHED CLASSMATE USING COURSES
        // needs to be implemented
        /*
            for classmate in CLASSMATES
                matchedCourses = []
                for course in classmate's courses
                    for userCourse in user's courses
                        if course is a match
                            add course to matchedCourses
                if matchedCourses is not empty
                    add classmate and matchedCourses to display list
         */
        
        for classmate in classmates {
            tableData.append(classmate.username)
        }
        
        tableView.dataSource = self
    }
}

extension PeopleViewController: UITableViewDataSource {
    
    // number of persons to display for entire section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // assign data to display in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create cell to add data to
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        // create person to add to cell
        let person = tableData[indexPath.row]
        // assign person to name label in created cell
        cell.nameLbl.text = person
        
        return cell
    }
}
