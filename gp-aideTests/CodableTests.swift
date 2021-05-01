//
//  CodableTests.swift
//  gp-aideTests
//
//  Created by Samuel Sandoval on 4/5/21.
//
@testable import gp_aide
import XCTest

class CodableTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveToDiskandReadFromDisk1() {
        let currGPA = GPA()
        let vc = ViewController()
        let studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3)
        currGPA.addTermCourse(studentCourse)
        vc.saveGPAToDisk(currGPA)
        vc.readGPAFromDisk()
        XCTAssertEqual(currGPA.currCredits, vc.readCredits)
    }
    func testSaveToDiskandReadFromDisk2() {
        let currGPA = GPA()
        let vc = ViewController()
        var studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3)
        currGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 223", classGrade: "B-", classCredits: 3)
        currGPA.addTermCourse(studentCourse)
        vc.saveGPAToDisk(currGPA)
        vc.readGPAFromDisk()
        XCTAssertEqual(currGPA.currCredits, vc.readCredits)
    }
    func testSaveToDiskandReadFromDisk3() {
        let currGPA = GPA()
        let vc = ViewController()
        var studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3)
        currGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 121", classGrade: "B+", classCredits: 3)
        currGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 223", classGrade: "B-", classCredits: 3)
        currGPA.addTermCourse(studentCourse)
        vc.saveGPAToDisk(currGPA)
        vc.readGPAFromDisk()
        XCTAssertEqual(currGPA.currCredits, vc.readCredits)
    }
    func testSaveUserToDiskandReasdFromDisk1(){
        let vc = ViewController()
        let currUser = User(username: "jeff", contactUrl: "https://instagram.com/jeffdude", courses: [], isPublic: true, hashedPassword: hashPassword(username: "jeff", password: "password"))
        vc.saveUserToDisk(currUser)
        vc.readUserFromDisk()
        XCTAssertEqual(currUser.username, vc.usernameRead)
    }
    
    func testSaveUserToDiskandReasdFromDisk2(){
        let vc = ViewController()
        let currUser = User(username: "jeff", contactUrl: "https://instagram.com/jeffdude", courses: [], isPublic: true, hashedPassword: hashPassword(username: "jeff", password: "password"))
        vc.saveUserToDisk(currUser)
        vc.readUserFromDisk()
        XCTAssertEqual(currUser.hashedPassword, vc.userPasswordRead)
    }
    
    func testSaveUserToDiskandReasdFromDisk3(){
        let vc = ViewController()
        let currUser = User(username: "jeff", contactUrl: "https://instagram.com/jeffdude", courses: [], isPublic: true, hashedPassword: hashPassword(username: "jeff", password: "password"))
        vc.saveUserToDisk(currUser)
        vc.readUserFromDisk()
        XCTAssertEqual(currUser.isPublic, vc.userVisiblityRead)
    }

}
