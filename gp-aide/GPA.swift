//
//  GPA.swift
//  gp-aide
//
//  Created by Sergio Herrera on 3/10/21.
//

import Foundation

class GPA {
    // grade points for 4.0 scale
    let grades = [
        "A+": 4.0,
        "A": 4.0,
        "A-": 3.7,
        "B+": 3.3,
        "B": 3.0,
        "B-": 2.7,
        "C+": 2.3,
        "C": 2.0,
        "C-": 1.7,
        "D+": 1.3,
        "D": 1.0,
        "D-": 0.7,
        "F": 0.0
    ]
    
    // list of classes for current term
    var term: [Course]
    var currGPA: Double
    var currCredits: Double
    // user may choose not to add previous GPA
    var previousGPA: [String: Double] = [:]
    
    init() {
        term = []
        currGPA = 0.0
        currCredits = 0.0
        previousGPA = ["gpa": 0.0, "credits": 0]
    }
    
    // action methods
    func getCurrentGPA() -> Double {
        return currGPA
    }
    
    func getCurrentCredits() -> Double {
        return currCredits
    }
    
    func getTerm() -> [Course] {
        return term
    }
    
    func setCurrentGPA(_ computedGPA: Double) {
        currGPA = computedGPA
    }

    func setPreviousGPA(_ prevGPA: Double, _ prevCredits: Double) {
        previousGPA["gpa"] = prevGPA
        previousGPA["credits"] = prevCredits
    }
    
    func addTermCourse(_ course: Course) {
        term.append(course)
    }
    
    func removeTermCourse(_ title: String) -> Bool {
        var found = false
        for (index, course) in term.enumerated() {
            if title == course.title {
                found = true
                term.remove(at: index)
                break
            }
        }
        
        // flag to check if course found in term
        return found
    }
    
    func addCredits(_ credits: Double) {
        currCredits += credits
    }
    
    func removeCredits(_ credits: Double) {
        currCredits -= credits
    }
    
    func calculateCurrentGPA() {
        var totalGradePoints = 0.0
        
        for course in term {
            let credits = Double(course.getCourseCredit())
            addCredits(credits)
            let grade = course.getCourseGrade()
            let gradePoints = grades[grade]
            totalGradePoints += gradePoints!
        }
        
        // gpa formula
        let calculatedGPA = (totalGradePoints / currCredits)
        setCurrentGPA(calculatedGPA)
    }
    
    func calculateCumulativeGPA() -> Double {
        var cumGPA = 0.0
        // calculate gradepoints for current and previous GPAs and insert into gpa formula
        let prevGradePoints = previousGPA["gpa"]! * previousGPA["credits"]!
        let currGradePoints = currGPA * currCredits
        cumGPA = (prevGradePoints + currGradePoints) / (previousGPA["credits"]! + currCredits)
        
        return cumGPA
    }
    
    // clear all fields and deinitialize
    deinit {
        term.removeAll()
        currGPA = 0.0
        currCredits = 0.0
        previousGPA.removeAll()
    }
}
