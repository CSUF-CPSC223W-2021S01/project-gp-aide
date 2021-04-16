//
//  ViewController.swift
//  gp-aide
//
//  Created by Jacob Nguyen on 2/23/21.
//

import UIKit

class ViewController: UIViewController {
    // ** Login VC **
    @IBOutlet var userName: UITextField!
    @IBOutlet var userPassword: UITextField!
    @IBOutlet var userSocialMedia: UITextField!

    // ** Calculator VC **
    // Course name, grad, and unit text fields
    @IBOutlet var courseName: UITextField!
    @IBOutlet var courseGrade: UITextField!
    @IBOutlet var courseUnits: UITextField!
    
    // User Feedback Labels
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var successLabel: UILabel!
    @IBOutlet var gpaLabel: UILabel!
    @IBOutlet var tableOfCourses: UITableView!
    
    // ** People VC **
    @IBOutlet var tableOfPeople: UITableView!
    
    var userGPA = GPA()
    var readGPA: Double = 0.0
    var readCredits: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readGPAFromDisk()
    }

    // Add a course to gpa object
    @IBAction func addCourse(_ sender: Any) {
        let currCourseName = courseName.text
        let currCourseGrade = courseGrade.text
        let currCourseUnits = Double(courseUnits.text!)
        
        // checks to see if all fields have been inputed correctly
        if currCourseName != nil, currCourseGrade != nil, currCourseUnits != nil {
            let currCourse = Course(currCourseName!, classGrade: currCourseGrade!, classCredits: currCourseUnits!)
            userGPA.addTermCourse(currCourse)
            
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
        if userGPA.getCurrentGPA().isNaN {
            print("Alert comes on!")
            let alert = UIAlertController(title: "Missing Course", message: "You need to enter a course before calculating GPA", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        } else {
            userGPA.setCurrentGPA(userGPA.getCurrentGPA())
            saveGPAToDisk(userGPA)
            gpaLabel.text = "GPA: \(String(userGPA.getCurrentGPA()))"
        }
    }
    
    // save data to Disk, store GPA instance
    func saveGPAToDisk(_ currGPA: GPA) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currGPA) {
            // makes Data JSON
            if let json = String(data: encoded, encoding: .utf8) {
                print(json)
            }
            UserDefaults.standard.set(encoded, forKey: "SavedGPA")
        }
        print("GPA saved to UserDefaults")
    }
    
    // read data from Disk, read the term so that the calculate GPA works.
    func readGPAFromDisk() {
        if let savedGPA = UserDefaults.standard.object(forKey: "SavedGPA") as? Data {
            let decoded = JSONDecoder()
            if let loadedGPA = try? decoded.decode(GPA.self, from: savedGPA) {
                print(" LoadedGPA current gpa: \(loadedGPA.currGPA)")
                print(" LoadedGPA current credits:  \(loadedGPA.currCredits)")
                readGPA = loadedGPA.currGPA
                readCredits = loadedGPA.currCredits
                userGPA.setPreviousGPA(loadedGPA.currGPA, loadedGPA.currCredits)
            }
        }
    }
    
    // sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard (sender as? UIButton) != nil else { return }
    }
}
