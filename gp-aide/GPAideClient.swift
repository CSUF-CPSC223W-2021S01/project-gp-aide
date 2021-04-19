//
//  GPAideClient.swift
//  gp-aide
//
//  Created by Ethan Davidson on 4/16/21.
//

import Foundation

//struct Course {
//    var title: String
//    var letterGrade: String
//}

struct Classmate {
    var username: String
    var contactUrl: String
    var courses: [Course]
}

struct User {
    var username: String
    var contactUrl: String
    var courses: [Course]
    var isPublic: Bool
    var hashedPassword: String
}

struct GPAideResponse {
    var isSuccessful: Bool
    var message: String?
}

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

func getSymbolFromAsciiCode(from asciiCode: Int) -> String {
    return String(UnicodeScalar(UInt8(asciiCode)))
}
