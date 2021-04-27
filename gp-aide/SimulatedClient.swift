//
//  SimulatedClient.swift
//  gp-aide
//
//  Created by Ethan Davidson on 4/18/21.
//

import Foundation

class SimulatedClient: GPAideClient {
    func fetchClassmates(taking courseTitle: String, complete: ([Classmate]) -> Void) {
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
        complete(foundClassmates)
    }
    
    func pullInfo(username: String, password: String, complete: (User) -> Void) {
        complete(TEST_USER)
    }
    
    func pushInfo(_ info: User, complete: (GPAideResponse) -> Void) {
        complete(TEST_RESPONSE)
    }
    
    func discardInfo(_ info: User, complete: (GPAideResponse) -> Void) {
        complete(TEST_RESPONSE)
    }
}
