//
//  GPA_Tests.swift
//  gp-aideTests
//
//  Created by Sergio Herrera on 3/17/21.
//

@testable import gp_aide
import XCTest

class GPA_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefaultInitializer() {
        let studentGPA = GPA()
        XCTAssertEqual(studentGPA.grades.count, 13)
    }
    
    func testDefaultInitializerGPA() {
        let studentGPA = GPA()
        XCTAssertEqual(studentGPA.currGPA, 0.0)
    }
    
    func testDefaultInitializerCredits() {
        let studentGPA = GPA()
        XCTAssertEqual(studentGPA.currCredits, 0.0)
    }

    func testDefaultInitializerPreviousGPA() {
        let studentGPA = GPA()
        XCTAssertEqual(studentGPA.previousGPA.count, 2)
    }
    
    func testDefaultInitializerTerm() {
        let studentGPA = GPA()
        XCTAssertNotNil(studentGPA.term)
    }
    
    func testAddCourseToTerm() {
        let studentGPA = GPA()
        let studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        XCTAssertEqual(studentGPA.term[0].getCourseTitle(), "CS 101")
    }
    
    func testRemoveCourseFound() {
        let studentGPA = GPA()
        let studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        XCTAssertEqual(studentGPA.removeTermCourse("CS 101"), true)
    }
    
    func testSingleCourseCredits() {
        let studentGPA = GPA()
        let studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3.0)
        studentGPA.addTermCourse(studentCourse)
        studentGPA.calculateCurrentGPA()
        XCTAssertEqual(studentGPA.currCredits, 3.0)
    }
    
    func testSingleCourseGPA() {
        let studentGPA = GPA()
        let studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentGPA.calculateCurrentGPA()
        XCTAssertEqual(studentGPA.currGPA, 4.0)
    }
    
    func testTwoCourseCredits() {
        let studentGPA = GPA()
        var studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 223", classGrade: "B-", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentGPA.calculateCurrentGPA()
        XCTAssertEqual(studentGPA.currCredits, 6.0)
    }
    
    func testTwoCourseGPA() {
        let studentGPA = GPA()
        var studentCourse = Course("CS 323", classGrade: "B", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 223", classGrade: "A", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentGPA.calculateCurrentGPA()
        XCTAssertEqual(studentGPA.currGPA, 3.5)
    }
    
    func testThreeCourseCredits() {
        let studentGPA = GPA()
        var studentCourse = Course("CS 101", classGrade: "A+", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 223", classGrade: "B-", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 431", classGrade: "C+", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentGPA.calculateCurrentGPA()
        XCTAssertEqual(studentGPA.currCredits, 9)
    }
    
    func testThreeCourseGPA() {
        let studentGPA = GPA()
        var studentCourse = Course("CS 323", classGrade: "B", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 223", classGrade: "A-", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 481", classGrade: "C+", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentGPA.calculateCurrentGPA()
        XCTAssertEqual(studentGPA.currGPA, 3)
    }
    
    func testSetPreviousGPA() {
        let studentGPA = GPA()
        studentGPA.setPreviousGPA(3.0, 9)
        XCTAssertEqual(studentGPA.previousGPA.count, 2)
    }
    
    func testPreviousGPAnumber() {
        let studentGPA = GPA()
        studentGPA.setPreviousGPA(3.0, 9)
        XCTAssertEqual(studentGPA.previousGPA["gpa"], 3.0)
    }
    
    func testSingleCourseCumulativeGPA() {
        let studentGPA = GPA()
        let studentCourse = Course("CS 101", classGrade: "A", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentGPA.calculateCurrentGPA()
        studentGPA.setPreviousGPA(3.0, 3)
        let cumulativeGPA = studentGPA.calculateCumulativeGPA()
        XCTAssertEqual(cumulativeGPA, 3.5)
    }
    
    func testTwoCurrentCourseCumulativeGPA() {
        let studentGPA = GPA()
        var studentCourse = Course("CS 101", classGrade: "A", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentCourse = Course("CS 223", classGrade: "C+", classCredits: 3)
        studentGPA.addTermCourse(studentCourse)
        studentGPA.calculateCurrentGPA()
        studentGPA.setPreviousGPA(4.0, 3)
        let cumulativeGPA = studentGPA.calculateCumulativeGPA()
        XCTAssertEqual(cumulativeGPA, 3.43)
    }
    
    func testDenitializerGPA() {
        var studentGPA: GPA?  = GPA()
        let studentCourse = Course("CS 101", classGrade: "A", classCredits: 3)
        studentGPA?.addTermCourse(studentCourse)
        studentGPA = nil
        XCTAssertNil(studentGPA?.term)
    }
    
}
