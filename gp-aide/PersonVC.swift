//
//  PersonVC.swift
//  gp-aide
//
//  Created by Sergio Herrera on 5/7/21.
//

import UIKit

struct Match {
    var name: String = ""
    var matchedCourses: String = ""
    var social: String = ""
}

class PersonVC: UIViewController {
    @IBOutlet var personView: UITableView!
    
    // classmates is pool of all classmates
    let classmates = TEST_CLASSMATES
    // userCourses are all courses user has added to term
    let userCourses: [String] = []
    
    // matches is initially empty
    // but stores a Match struct obj for every match found in classmates to current courses "cart"
    var matches: [Match] = []
    
    func updateMatches(courses: [String]) {
        matches = []
        for classmate in classmates {
            var foundCourses: [String] = []
            for classmateCourse in classmate.courses {
                for course in courses {
                    if classmateCourse.title.lowercased() == course.lowercased() {
                        foundCourses.append(course)
                    }
                }
            }
            if foundCourses.count > 0 {
                let matchedCoursesOutput = foundCourses.joined(separator: ", ")
                let match = Match(name: classmate.username, matchedCourses: matchedCoursesOutput, social: classmate.contactUrl)
                matches.append(match)
            }
        }
        print("Matches: \(matches)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("PersonVC is shown")
        
        // UserCourses.shared is singleton instance with updated courses list property
        let userCourses = UserCourses.shared.courses
        print("Executed")
        print(userCourses)
        
        // sampleCourses should be replaced with updated list of added user courses
        updateMatches(courses: userCourses)
    }
}

extension PersonVC: UITableViewDataSource {
    // number of persons to display for entire section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    // map each person match to cell labels
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create person to add to cell
        let person = matches[indexPath.row]
        // create cell to add data to
        let cell = personView.dequeueReusableCell(withIdentifier: "personCell") as! PersonCell
        
        // set person match values to cell labels using
        // setPerson() which is defined in PersonCell.swift
        cell.setPerson(person: person)
        
        return cell
    }
}
