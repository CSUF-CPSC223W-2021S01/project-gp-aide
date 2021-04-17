//
//  GPAideClient.swift
//  gp-aide
//
//  Created by Ethan Davidson on 4/16/21.
//

import Foundation

struct Classmate {
  var username: String
  var contactUrl: String
  var courses: Course[]
}

struct User: Classmate {
  var isPublic: Bool
  var hashedPassword: String
}

struct GPAideResponse {
  var isSuccessful: String
  var message: String?
}

// Original Issue: https://github.com/CSUF-CPSC223W-2021S01/project-gp-aide/issues/35#issuecomment-818950235
protocol GPAideClient: class {
  func fetchClassmates(taking courseTitle: String) -> [Classmate]
  func pullInfo(username: String, password: String) -> User
  func pushInfo(_ info: User) -> GPAideResponse
  func discardInfo(_ info: User) -> GPAideResponse
}

func hashPassword(
  username: String,
  password: String
) -> String {
  // TODO(@EthanThatOneKid): Create simple password hashing function.
  return "\(username).\(password)"
}

func getAsciiCodeFromSymbol(from symbol: String) -> Int {
  let scalar = symbol.unicodeScalars
  return Int(scalar[scalar.startIndex].value)
}

func getSymbolFromAsciiCode(from: asciiCode: Int) -> String {
  return String(UnicodeScalar(UInt8(asciiCode)))
}