//
//  unitTest.swift
//  unitTest
//
//  Created by Takeshi Komori on 2023/04/04.
//

// TODO: mainターゲットから除却

import XCTest

final class UnitTest: XCTestCase {
    
    func testTokenize() {
        XCTContext.runActivity(named: "binaryOperator") { _ in
            let sampleCode = """
                let test = 1000
                var test2 = 1000 + 10
                var test3 = 1000 - 10
                var test4 = 1000 * 10
                var test5 = 1000 / 10
                var test6 = 1000 % 10\n
"""
            let expected: [Token] = [
                .reservedWord(.let), .identifier("test"), .other(.equal), .number(1000),
                .reservedWord(.var), .identifier("test2"), .other(.equal), .number(1000), .binaryOperator(.plus), .number(10),
                .reservedWord(.var), .identifier("test3"), .other(.equal), .number(1000), .binaryOperator(.minus), .number(10),
                .reservedWord(.var), .identifier("test4"), .other(.equal), .number(1000), .binaryOperator(.asterisk), .number(10),
                .reservedWord(.var), .identifier("test5"), .other(.equal), .number(1000), .binaryOperator(.slash), .number(10),
                .reservedWord(.var), .identifier("test6"), .other(.equal), .number(1000), .binaryOperator(.percent), .number(10),
                .other(.eof)
            ]
            let tokens = tokenize(input: sampleCode)
            XCTAssertEqual(tokens, expected)
        }
        
        XCTContext.runActivity(named: "roundBlacket, curlyBlace, squareBlacket") { _ in
            let sampleCode = """
                func test() -> [Int] {
                    return [10]
                }
                print(test())
"""
            let expected: [Token] = [
                .reservedWord(.func), .identifier("test"), .roundBlacket(.left), .roundBlacket(.right), .other(.arrow), .squareBlacket(.left), .identifier("Int"), .squareBlacket(.right), .curlyBlace(.left),
                .reservedWord(.return), .squareBlacket(.left), .number(10), .squareBlacket(.right),
                .curlyBlace(.right),
                .identifier("print"), .roundBlacket(.left), .identifier("test"), .roundBlacket(.left), .roundBlacket(.right), .roundBlacket(.right),
                .other(.eof)
            ]
            let tokens = tokenize(input: sampleCode)
            XCTAssertEqual(tokens, expected)
        }
        
        XCTContext.runActivity(named: "reservedWord") { _ in
            
        }
        
        XCTContext.runActivity(named: "arrow") { _ in
            
        }
        
        XCTContext.runActivity(named: "eof") { _ in
            
        }
    }
}
