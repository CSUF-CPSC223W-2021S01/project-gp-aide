//
//  SimulatedClientTests.swift
//  gp-aideTests
//
//  Created by Ethan Davidson on 4/18/21.
//

@testable import gp_aide
import XCTest

class SimulatedClientTests: XCTestCase {
    var client: SimulatedClient = SimulatedClient()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClassmatesCount() {
        let classmatesCount = TEST_CLASSMATES
        XCTAssertEqual(classmatesCount.count, 4)
    }
    
    func testFoundClassmatesByClassOne() {
        let testCourse = "CPSC 223"
        let foundClassmates = self.client.fetchClassmates(taking: testCourse)
        XCTAssertEqual(foundClassmates.count, 4)
    }
    
    func testFoundClassmatesByClassTwo() {
        let testCourse = "CPSC 481"
        let foundClassmates = self.client.fetchClassmates(taking: testCourse)
        XCTAssertEqual(foundClassmates.count, 2)
    }
    
    func testFoundClassmatesByClassThree() {
        let testCourse = "CPSC 315"
        let foundClassmates = self.client.fetchClassmates(taking: testCourse)
        XCTAssertEqual(foundClassmates.count, 1)
    }
    
    func testFoundClassmatesByClassFour() {
        let testCourse = "CPSC 411"
        let foundClassmates = self.client.fetchClassmates(taking: testCourse)
        XCTAssertEqual(foundClassmates.count, 1)
    }

    func testNoClassmatesMatch() {
        let classmates = self.client.fetchClassmates(taking: "courseTitle1")
        XCTAssertEqual(classmates.count, 0)
    }

    func testPullInfo() {
        let info = client.pullInfo(username: TEST_USER.username, password: TEST_USER.hashedPassword)
        XCTAssertEqual(info, TEST_USER)
    }

    func testPushInfo() {
        let response = client.pushInfo(TEST_USER)
        XCTAssertTrue(response.isSuccessful)
    }

    func testDiscardInfo() {
        let response = client.discardInfo(TEST_USER)
        XCTAssertTrue(response.isSuccessful)
    }
    
    
}
