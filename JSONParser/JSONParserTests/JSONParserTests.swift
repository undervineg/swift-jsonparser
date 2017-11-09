//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import XCTest
@testable import JSONParser

class JSONParserTests: XCTestCase {
    
    func testParsingJSONData() {
        do {
            let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
            try JSONParser.parse(jsonString)
        }catch {
            XCTAssertNoThrow(error, error.localizedDescription)
        }
    }
    
    func testStringDataIsNotNil() {
        let parsedData = JSONData(["name":"KIM JUNG"])
        XCTAssertNotNil(parsedData)
    }
    
    func testNumberDataIsNotNil() {
        let parsedData = JSONData(["level" :5])
        XCTAssertNotNil(parsedData)
    }
    
    func testBoolDataIsNotNil() {
        let parsedData = JSONData(["married": true])
        XCTAssertNotNil(parsedData)
    }
    
    func testCountOfNumberIsRight() {
        let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let parsedData = try JSONParser.parse(jsonString)
        XCTAssertEqual(parsedData[0].number.count, 3)
    }
    
    func testCountOfStringIsRight() {
        let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let parsedData = try JSONParser.parse(jsonString)
        XCTAssertEqual(parsedData[0].string.count, 3)
    }
    
    func testCountOfBoolIsRight() {
        let jsonString: String = "[ 10, \"jk\", 4, \"314\", 99, \"crong\", false ]"
        let parsedData = try JSONParser.parse(jsonString)
        XCTAssertEqual(parsedData[0].bool.count, 1)
    }
    
}

