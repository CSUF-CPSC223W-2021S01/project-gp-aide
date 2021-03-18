//
//  ViewController.swift
//  gp-aide
//
//  Created by Jacob Nguyen on 2/23/21.
//

import UIKit

class ViewController: UIViewController {
    //Course name, grad, and unit text fields
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseGrade: UITextField!
    @IBOutlet weak var courseUnits: UITextField!
    
    //User Feedback Labels
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    
    var userGPA = GPA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //Add a course to gpa object
    @IBAction func addCourse(_ sender: Any) {
        let currCourseName = courseName.text
        let currCourseGrade = courseGrade.text
        let currCourseUnits = Int(courseUnits.text!)
        
        //checks to see if all fields have been inputed correctly
        if currCourseName != nil && currCourseGrade != nil && currCourseUnits != nil {
            let currCourse = Course(currCourseName!, classGrade:currCourseGrade!, classCredits:currCourseUnits!)
            userGPA.addTermCourse(currCourse)
            
            //Hide Error Message if on and show success message
            errorLabel.isHidden = true
            successLabel.isHidden = false
            successLabel.text = "Success added \(currCourse.title) with grade \(currCourse.grade) and \(currCourse.credits) Units"
            
            //reset text fields to empty
            courseName.text = ""
            courseGrade.text = ""
            courseUnits.text = ""
        } else {
            //show error label
            errorLabel.isHidden = false
            successLabel.isHidden = true
        }

      
    }
    
    //calculate GPA
    @IBAction func calculateGPA(_ sender: Any) {
        errorLabel.isHidden = true
        successLabel.isHidden = true
        userGPA.calculateCurrentGPA()
        gpaLabel.text = "GPA: \(String(userGPA.getCurrentGPA()))"
    }
}

