//
//  GPAideClient.swift
//  gp-aide
//
//  Created by Ethan Davidson on 4/16/21.
//

import Foundation

struct Classmate: Equatable {
    static func == (lhs: Classmate, rhs: Classmate) -> Bool {
        return lhs.username == rhs.username
    }

    var username: String
    var contactUrl: String
    var courses: [Course]
}

struct User: Equatable, Codable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }

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
    func fetchClassmates(taking courseTitle: String, complete: ([Classmate]) -> Void)
    func pullInfo(username: String, password: String, complete: (User) -> Void)
    func pushInfo(_ info: User, complete: (GPAideResponse) -> Void)
    func discardInfo(_ info: User, complete: (GPAideResponse) -> Void)
}

func hashPassword(username: String, password: String) -> String {
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
