//
//  UserCourses.swift
//  gp-aide
//
//  Created by Sergio Herrera on 5/7/21.
//

import Foundation

class UserCourses {
    
    static let shared = UserCourses()
    public var courses: [String]
    
    private init() {
        courses = []
    }
    
    public func addCourse(course: String) {
        courses.append(course)
        print("added course to singleton courses property list")
        print("courses length is \(courses.count)")
    }
    
}

var USER_COURSES: [String] = []
