//
//  RandomizedClient.swift
//  gp-aide
//
//  Created by Ethan Davidson on 5/4/21.
//

import Foundation

// TODO(@Herrera741): Add the `withQueries` URL extension here.
// See: https://github.com/CSUF-CPSC223W-2021S01/project-gp-aide/issues/53
// `extension URL { ... }`
// Then we can change `let fakeDataUrl = ...` to
// ```
// let baseURL = URL(string: "https://fakerapi.it/api/v1/persons")
// let fakeDataUrl = baseURL.withQueries(["_quantity": String(CLASSMATE_AMOUNT)])
// ```

let fakeDataUrl = URL(string: "https://fakerapi.it/api/v1/persons?_quantity=\(CLASSMATE_AMOUNT)")

class RandomizedClient: GPAideClient {
    func fetchClassmates(taking courseTitle: String, complete: @escaping ([Classmate]) -> Void) {
        var foundClassmates: [Classmate] = []
        let task = URLSession.shared.dataTask(with: fakeDataUrl!) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let people = try? decoder.decode([[String: String]].self, from: data)
                let course = Course(courseTitle, classGrade: "A", classCredits: 3.0)
                for person in people! {
                    let classmate = Classmate(username: person["email"]!, contactUrl: person["website"]!, courses: [course])
                    foundClassmates.append(classmate)
                }
            }
            complete(foundClassmates)
        }
        task.resume()
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
