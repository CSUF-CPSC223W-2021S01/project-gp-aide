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
    var credits: Int
    
    init(classTitle: String, classGrade: String, classCredits: Int) {
        self.title = classTitle
        self.grade = classGrade
        self.credits = classCredits
    }
    
    func setCourseTitle(_ classTitle: String) {
        title = classTitle
    }

    func setCourseGrade(_ classGrade: String) {
        grade = classGrade
    }

    func setCourseCredit(_ classCredits: Int) {
        credits = classCredits
    }
    
    func getCourseTitle() -> String {
        return title
    }
    
    func getCourseGrade() -> String {
        return grade
    }

    func getCourseCredit() -> Int {
        return credits
    }
}
