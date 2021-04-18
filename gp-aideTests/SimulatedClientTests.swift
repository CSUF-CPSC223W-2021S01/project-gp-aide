//
//  SimulatedClientTests.swift
//  gp-aideTests
//
//  Created by Ethan Davidson on 4/18/21.
//

@testable import gp_aide
import XCTest

class SimulatedClientTests: XCTestCase {
    var client: SimulatedClient

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.client = SimulatedClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchClassmates() {
        let classmates = self.client.fetchClassmates(taking: "courseTitle1")
        XCTAssertEqual(classmates, TEST_CLASSMATES)

        print(client.pushInfo(TEST_USER))
        print(client.discardInfo(TEST_USER))
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
