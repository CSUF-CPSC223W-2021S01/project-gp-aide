//
//  CourseTests.swift
//  gp-aideTests
//
//  Created by Samuel Sandoval on 3/10/21.
//

@testable import gp_aide
import XCTest

class CourseTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCourseInitializer() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        XCTAssertEqual(currCourse.getCourseTitle(), "FirstCourse")
    }
    func testCourseInitializerClassCreditZero() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 0)
        XCTAssertEqual(currCourse.getCourseCredit(), 0)
    }

    func testCourseInitializerClassCreditAbove5() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 6)
        XCTAssertEqual(currCourse.getCourseCredit(), 0)
    }

    func testSetCourseTitle() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        currCourse.setCourseTitle("NewCourseTitle")
        XCTAssertEqual(currCourse.getCourseTitle(), "NewCourseTitle")
    }

    func testSetCourseGrade() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        currCourse.setCourseGrade("B+")
        XCTAssertEqual(currCourse.getCourseGrade(), "B+")
    }

    func testSetCourseCredits() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        currCourse.setCourseCredit(1)
        XCTAssertEqual(currCourse.getCourseCredit(), 1)
    }

    func testSetCourseCreditsAtZero() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        currCourse.setCourseCredit(0)
        XCTAssertEqual(currCourse.getCourseCredit(), 3)
    }

    func testSetCourseCreditsAboveFive() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        currCourse.setCourseCredit(6)
        XCTAssertEqual(currCourse.getCourseCredit(), 3)
    }

    func testChangeMultipleVariables() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        currCourse.setCourseTitle("SecondCourse")
        currCourse.setCourseGrade("B")
        currCourse.setCourseCredit(4)
        XCTAssert(currCourse.printOut == "SecondCourse: Grade Received B. Credits for course: 4 cr \n")
    }

    func testPrintOut() {
        let currCourse = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        currCourse.setCourseTitle("NewCourseTitle")
        XCTAssert(currCourse.printOut == "NewCourseTitle: Grade Received A+. Credits for course: 3 cr \n")
    }

    func testCourseDeInitializer() {
        var currCourse: Course? = Course("FirstCourse", classGrade: "A+", classCredits: 3)
        currCourse = nil
        XCTAssertEqual(currCourse?.grade, nil)
    }
}
