//
//  GPA.swift
//  gp-aide
//
//  Created by Sergio Herrera on 3/10/21.
//

import Foundation

class GPA: Codable {
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
    
    private enum CodingKeys: String, CodingKey {
        case term
        case currGPA
        case currCredits
        case previousGPA
    }
    
    init() {
        term = []
        currGPA = 0.0
        currCredits = 0.0
        previousGPA = ["gpa": 0.0, "credits": 0]
    }

    // Decode init
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        term = try values.decode([Course].self, forKey: .term)
        currGPA = try values.decode(Double.self, forKey: .currGPA)
        currCredits = try values.decode(Double.self, forKey: .currCredits)
        previousGPA = try values.decode([String: Double].self, forKey: .previousGPA)
    }

    // Encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(term, forKey: .term)
        try container.encode(currGPA, forKey: .currGPA)
        try container.encode(currCredits, forKey: .currCredits)
        try container.encode(previousGPA, forKey: .previousGPA)
    }
    
    // action methods
    func getCurrentGPA() -> Double {
        let formattedGPA = round(currGPA * 100) / 100
        return formattedGPA
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
        addCredits(course.credits)
        calculateCurrentGPA()
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
        self.currCredits += credits
    }
    
    func removeCredits(_ credits: Double) {
        currCredits -= credits
    }
    
    func calculateCurrentGPA() {
        var totalQualityPoints = 0.0

        for course in term {
            let courseCredits = Double(course.getCourseCredit())
//            addCredits(courseCredits)
            let courseGrade = course.getCourseGrade()
            let gradePoints = courseCredits * grades[courseGrade]!
            totalQualityPoints += gradePoints
        }
        // gpa formula
        let calculatedGPA = (totalQualityPoints / currCredits)
        setCurrentGPA(calculatedGPA)
    }
    
    func calculateCumulativeGPA() -> Double {
        var cumGPA = 0.0
        // calculate gradepoints for current and previous GPAs and insert into gpa formula
        let prevQualityPoints = previousGPA["gpa"]! * previousGPA["credits"]!
        let currQualityPoints = currGPA * currCredits
        cumGPA = (prevQualityPoints + currQualityPoints) / (previousGPA["credits"]! + currCredits)
        
        let formattedCumGPA = round(cumGPA * 100) / 100
        
        return formattedCumGPA
    }
    
    // clear all fields and deinitialize
    deinit {
        term.removeAll()
        currGPA = 0.0
        currCredits = 0.0
        previousGPA.removeAll()
    }
}
