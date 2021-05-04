//
//  RandomizedClient.swift
//  gp-aide
//
//  Created by Ethan Davidson on 5/4/21.
//

import Foundation

let fakeDataUrl = "https://fakerapi.it/api/v1/persons?_quantity=10"

class RandomizedClient: GPAideClient {
    func fetchClassmates(taking courseTitle: String, complete: ([Classmate]) -> Void) {
        var foundClassmates: [Classmate] = []
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: fakeDataUrl, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                        taskCallback(true, json as AnyObject?)
                    } else {
                        taskCallback(false, json as AnyObject?)
                    }
            }
            complete(foundClassmates)
        })
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
