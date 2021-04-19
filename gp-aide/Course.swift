//
//  Course.swift
//  gp-aide
//
//  Created by Samuel Sandoval on 3/9/21.
//

import Foundation

class Course {
    var title: String
    var grade: String
    var credits: Double
    var printOut: String {
        var courseStr: String = ""
        courseStr += "\(title): Grade Received \(grade). Credits for course: \(credits) cr \n"
        return courseStr
    }

    init(_ classTitle: String, classGrade: String, classCredits: Double) {
        self.title = classTitle
        self.grade = classGrade
        self.credits = 0
        if classCredits <= 5, classCredits > 0 {
            self.credits = classCredits
        }
    }

    func setCourseTitle(_ classTitle: String) {
        title = classTitle
    }

    func setCourseGrade(_ classGrade: String) {
        grade = classGrade
    }

    func setCourseCredit(_ classCredits: Double) {
        if classCredits <= 5, classCredits > 0 {
            credits = classCredits
        }
    }

    func getCourseTitle() -> String {
        return title
    }

    func getCourseGrade() -> String {
        return grade
    }

    func getCourseCredit() -> Double {
        return credits
    }

    deinit {
        print("Course object deinitialized!")
    }
}
