//
//  ViewController.swift
//  gp-aide
//
//  Created by Jacob Nguyen on 2/23/21.
//

import UIKit

class ViewController: UIViewController {
    // Course name, grad, and unit text fields
    @IBOutlet var courseName: UITextField!
    @IBOutlet var courseGrade: UITextField!
    @IBOutlet var courseUnits: UITextField!
    
    // User Feedback Labels
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var successLabel: UILabel!
    @IBOutlet var gpaLabel: UILabel!
    
    var userGPA = GPA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readCourseFromDisk()
    }

    // Add a course to gpa object
    @IBAction func addCourse(_ sender: Any) {
        let currCourseName = courseName.text
        let currCourseGrade = courseGrade.text
        let currCourseUnits = Int(courseUnits.text!)
        
        // checks to see if all fields have been inputed correctly
        if currCourseName != nil, currCourseGrade != nil, currCourseUnits != nil {
            let currCourse = Course(currCourseName!, classGrade: currCourseGrade!, classCredits: currCourseUnits!)
            userGPA.addTermCourse(currCourse)
            saveCourseToDisk(currCourse)
            // Hide Error Message if on and show success message
            errorLabel.isHidden = true
            successLabel.isHidden = false
            successLabel.text = "Success added \(currCourse.title) grade: \(currCourse.grade) and \(currCourse.credits) units"
            
            // reset text fields to empty
            courseName.text = ""
            courseGrade.text = ""
            courseUnits.text = ""
        } else {
            // show error label
            errorLabel.isHidden = false
            successLabel.isHidden = true
        }
    }
    
    // calculate GPA
    @IBAction func calculateGPA(_ sender: Any) {
        errorLabel.isHidden = true
        successLabel.isHidden = true
        userGPA.calculateCurrentGPA()
        gpaLabel.text = "GPA: \(String(userGPA.getCurrentGPA()))"
    }
    
    // save data to Disk
    func saveCourseToDisk(_ currCourse: Course) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currCourse) {
            UserDefaults.standard.set(encoded, forKey: "SavedCourse")
        }
        
        print("Course saved to UserDefaults")
    }
    
    // read Disk
    func readCourseFromDisk() {
        if let savedCourse = UserDefaults.standard.object(forKey: "SavedCourse") as? Data {
            let decoder = JSONDecoder()
            if let loadedCourse = try? decoder.decode(Course.self, from: savedCourse) {
                print(loadedCourse.title)
            }
        }
    }
}
