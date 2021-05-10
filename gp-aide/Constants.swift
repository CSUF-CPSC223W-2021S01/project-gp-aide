//
//  Constants.swift
//  gp-aide
//
//  Created by Ethan Davidson on 3/24/21.
//

// Letter grades
//enum LetterGrade: String {
//  case a_plus = "A+"
//  case a = "A+"
//  case a_minus = "A+"
//  case b_plus = "A+"
//  case b = "A+"
//  case b_minus = "A+"
//  case c_plus = "A+"
//  case c = "A+"
//  case c_minus = "A+"
//  case d_plus = "A+"
//  case d = "A+"
//  case d_minus = "A+"
//  case a_plus = "A+"
//}

// Miscellaneous Constants
let CLASSMATE_AMOUNT = 12

// Grade points for 4.0 scale
let GRADES = [
  "A+": 4.0,
  "A": 4.0,
  "A-": 3.7,
  "B+": 3.3,
  "B": 3.0,
  "B-": 2.7,
  "C+": 2.3,
  "C": 2.0,
  "C-": 1.7,
  "D+": 1.3,
  "D": 1.0,
  "D-": 0.7,
  "F": 0.0
]

// --- Simulated Client Constants ---
let TEST_CLASSMATES = [
  Classmate(
    username: "EthanThatOneAdult",
    contactUrl: "Discord: EthanThatOneKid#3456",
    courses: [Course("CPSC 223W", classGrade: "A+", classCredits: 3.0),
              Course("CPSC 481", classGrade: "C", classCredits: 3.0)]
  ),
  Classmate(
    username: "Samuel Sandoval",
    contactUrl: "Discord: SJSands#7010",
    courses: [Course("CPSC 223W", classGrade: "B", classCredits: 3.0),
              Course("CPSC 315", classGrade: "A", classCredits: 3.0)]
  ),
  Classmate(
    username: "Sergio Herrera",
    contactUrl: "Discord: Sergio#7941",
    courses: [Course("CPSC 223W", classGrade: "C+", classCredits: 3.0),
              Course("CPSC 481", classGrade: "B+", classCredits: 3.0)]
  ),
  Classmate(
    username: "Nacob Jguyen",
    contactUrl: "Discord: Jaegubwin#4676",
    courses: [Course("CPSC 223W", classGrade: "B-", classCredits: 3.0),
              Course("CPSC 411", classGrade: "A", classCredits: 3.0)]
  )
]

let TEST_USER = User(
  username: "EthanThatOneKid",
  contactUrl: "https://github.com/EthanThatOneKid",
  courses: [],
  isPrivate: true,
  hashedPassword: "THIS_DOESNT_MATTER_YET"
)

let TEST_RESPONSE = GPAideResponse(
  isSuccessful: true,
  message: "This request was executed successfully!"
)
