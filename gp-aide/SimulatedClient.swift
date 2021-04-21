//
//  SimulatedClient.swift
//  gp-aide
//
//  Created by Ethan Davidson on 4/18/21.
//

import Foundation

class SimulatedClient: GPAideClient {
    // return list of classmates taking same class
    func fetchClassmates(taking courseTitle: String) -> [Classmate] {
        var foundClassmates: [Classmate] = []
        for classmate in TEST_CLASSMATES {
            for course in classmate.courses {
                if course.title == courseTitle {
                    // add result to final list
                    foundClassmates.append(classmate)
                }
            }
        }
        // return list of classmates found
        return foundClassmates
    }
    
    func pullInfo(username: String, password: String) -> User {
        return TEST_USER
    }
    
    func pushInfo(_ info: User) -> GPAideResponse {
        return TEST_RESPONSE
    }
    
    func discardInfo(_ info: User) -> GPAideResponse {
        return TEST_RESPONSE
    }
}
