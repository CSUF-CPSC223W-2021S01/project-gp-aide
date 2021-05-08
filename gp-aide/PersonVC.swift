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
    var matches: [String] = []
    
    @IBOutlet var personView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        for classmate in TEST_CLASSMATES {
//            self.matches.append(classmate.username)
//        }
        
        personView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("PersonVC is shown")
        print("user courses are \(userCourses)")
        
        let client = RandomizedClient()
        client.fetchClassmates(taking: "CPSC 223W") { classmates in
            self.matches = []
            for classmate in classmates {
                self.matches.append(classmate.username)
            }
        }
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
        let username = matches[indexPath.row]
        // assign person to name label in created cell
        cell.textLabel?.text = username
        
        return cell
    }
}
