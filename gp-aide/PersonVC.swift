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
}

class PersonVC: UIViewController {
    
    @IBOutlet var personView: UITableView!
    
    // classmates is pool of all classmates
    let classmates = TEST_CLASSMATES
    // userCourses are all courses user has added to term
    let userCourses: [String] = []
    
    // matches is initially empty
    // but stores a Match struct obj for every match found in classmates to current courses "cart"
    var matches: [Match] = [Match(name: "EthanThatOneKid", matchedCourses: "CPSC 223, CPSC 481"), Match(name: "SamuelThatOneKid", matchedCourses: "CPSC 223")]
    
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
//        print("user courses are \(userCourses)")
        
//        let client = RandomizedClient()
//        client.fetchClassmates(taking: "CPSC 223W") { classmates in
//            self.matches = []
//            for classmate in classmates {
//                self.matches.append(classmate.username)
//            }
//        }
        
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
