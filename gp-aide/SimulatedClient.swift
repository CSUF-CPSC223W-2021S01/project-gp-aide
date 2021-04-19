//
//  SimulatedClient.swift
//  gp-aide
//
//  Created by Ethan Davidson on 4/18/21.
//

import Foundation

class SimulatedClient: GPAideClient {
  func fetchClassmates(taking courseTitle: String) -> [Classmate] {
    return TEST_CLASSMATES
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
