//
//  ViewController.swift
//  gp-aide
//
//  Created by Jacob Nguyen on 2/23/21.
//

import UIKit

class ViewController: UIViewController, UITabBarControllerDelegate {
    // ** Settings Screen **

    @IBOutlet var userName: UITextField!
    @IBOutlet var userPassword: UITextField!
    @IBOutlet var userSocialMedia: UITextField!
    @IBOutlet var toggle: UISwitch!
    @IBOutlet var logInSubmitButton: UIButton!

    // ** Calculator Screen **
    // Course name, grad, and unit text fields
    @IBOutlet var courseName: UITextField!
    @IBOutlet var courseGrade: UITextField!
    @IBOutlet var courseUnits: UITextField!
    @IBOutlet weak var calcGpaButton: UIButton!
    @IBOutlet weak var addCourseButton: UIButton!
    
    let gradeChoices = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
    var pickerView = UIPickerView()

    // User Feedback Labels
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var successLabel: UILabel!
    @IBOutlet var gpaLabel: UILabel!

    // General Variables
    var userGPA = GPA()
    var courses: [Course] = []
    var readGPA: Double = 0.0
    var readCredits: Double = 0.0
    var usernameRead: String = ""
    var userPasswordRead: String = ""
    var userVisiblityRead: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBarController?.delegate = self
        readGPAFromDisk()
        readUserFromDisk()
        // isUserLoggedIn()
        pickerView.delegate = self
        pickerView.dataSource = self
        calcGpaButton.layer.cornerRadius = 20.0
        addCourseButton.layer.cornerRadius = 20.0
        
        
        //   courseGrade.inputView = pickerView
    }

    // MARK: - Add a course to userGPA object

    @IBAction func addCourse(_ sender: Any) {
        let currCourseName = courseName.text
        let currCourseGrade = courseGrade.text
        let currCourseUnits = Double(courseUnits.text!)

        // checks to see if all fields have been inputed correctly
        if currCourseName != nil, currCourseGrade != nil, currCourseUnits != nil {
            let currCourse = Course(currCourseName!, classGrade: currCourseGrade!, classCredits: currCourseUnits!)
            userGPA.addTermCourse(currCourse)
            courses.append(currCourse)
            print("Courses arr size \(courses.count)")

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

    // MARK: - calculate GPA Method

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

    // MARK: - Codable Methods

    // save data to Disk, store GPA instance
    func saveGPAToDisk(_ currObject: GPA) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currObject) {
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

    // save User Login to Disk
    func saveUserToDisk(_ currObject: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currObject) {
            if let json = String(data: encoded, encoding: .utf8) {
                print(json)
            }
            UserDefaults.standard.set(encoded, forKey: "SavedUser")
        }
        print("User saved to UserDefaults")
    }

    // read data from Disk, read UserLogin info.
    func readUserFromDisk() {
        if let savedGPA = UserDefaults.standard.object(forKey: "SavedUser") as? Data {
            let decoded = JSONDecoder()
            if let loadedUser = try? decoded.decode(User.self, from: savedGPA) {
                print(" LoadedUser username: \(loadedUser.username)")
                print(" LoadedUser password:  \(loadedUser.hashedPassword)")
                print(" LoadedUser public:  \(loadedUser.isPrivate)")
                usernameRead = loadedUser.username
                userPasswordRead = loadedUser.hashedPassword
                userVisiblityRead = loadedUser.isPrivate
            }
        }
    }

    // MARK: - Private User method, Settings Login method, UserIsLoggedIn at view load

    @IBAction func isPrivateUser(_ sender: Any) {
        // Hide(disable tapping) for people screen
        let tabBarControllerItems = tabBarController?.tabBar.items
        if toggle.isOn == true {
            if let tabArray = tabBarControllerItems {
                let tabBarItem2 = tabArray[1]
                tabBarItem2.isEnabled = false
            }
        }
    }

    @IBAction func didUserSubmitLogIn(_ sender: Any) {
        guard userName.text != "", userPassword.text != "", userSocialMedia.text != "" else {
            print("Alert comes on!")
            let alert = UIAlertController(title: "Missing Input", message: "You need text in every input", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            return
        }
        let classmateUser = User(username: userPassword.text!, contactUrl: userPassword.text!, courses: [], isPrivate: toggle.isOn, hashedPassword: hashPassword(username: userName.text!, password: userPassword.text!))
        saveUserToDisk(classmateUser)
        readUserFromDisk()
        _ = isUserLoggedIn()
    }

    // when app opens check if the user has set a password and such
    func isUserLoggedIn() -> Bool {
        if userPasswordRead == "" {
            // Alert comes on
            print("Alert comes on! on isUserLogin function")
            let alert = UIAlertController(title: "Logged Out", message: "You are not logged in, please log in to view the People Screen", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)

            // disables the 2nd tab bar item
            let tabBarControllerItems = tabBarController?.tabBar.items
            if let tabArray = tabBarControllerItems {
                let tabBarItem2 = tabArray[1]
                tabBarItem2.isEnabled = false
            }
            return false
        } else {
            let tabBarControllerItems = tabBarController?.tabBar.items
            if let tabArray = tabBarControllerItems {
                let tabBarItem2 = tabArray[1]
                tabBarItem2.isEnabled = true
            }
            return true
        }
    }

    // tab bar function to detect what item the user is at
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
        // check if on people screen, check if user is logged, if not then make them go to settings screen
        if tabBarIndex == 1 {
            print("at second tab")
            let value = isUserLoggedIn()
            if value == false {
                tabBarController.selectedIndex = 2
            }
        }

    }

    // MARK: - Table View Functions for Calculator View Controller

//    func tableView(_ tableOfCourses: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You tapped me!")
//        tableOfCourses.deselectRow(at: indexPath, animated: true)
//        performSegue(withIdentifier: "showPeople", sender: self)
//    }
//
//    func tableView(_ tableOfCourses: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableOfCourses.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        if courses.count > 0 {
//            let courseObj = courses[indexPath.row]
//            let courseTitle = courseObj.getCourseTitle()
//            cell.textLabel?.text = courseTitle
//        }
//        return cell
//    }
//
//    func tableView(_ tableOfCourses: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return courses.count
//    }
}

// Extends the to support the picker
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradeChoices.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent compnent: Int) -> String? {
        return gradeChoices[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        courseGrade.text = gradeChoices[row]
        courseGrade.resignFirstResponder()
    }
}
