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
            let sampleCode = """
                // `let`
                let test = 10

                // `var`
                var test2 = 12

                // `if`
                if test < 10 {
                  print(test)

                // `else`
                } else {
                  print(test2)
                }

                // `func`
                func testMethod() -> [Int] {

                    // `return`
                    return [10]
                }

                // `enum`
                enum Hoge {
 
                // `case`
                   case test1
                   case test2
                }

                // `while`
                while test2 < 20 {

                  if test2 == 5 {

                     // `break`
                     break
                  } else {
                     test2 += 1

                     // `continue`
                     continue
                  }
                }
"""
            let expected: [Token] = [
                // `let`
                .reservedWord(.let), .identifier("test"), .other(.equal), .number(10),
                // `var`
                .reservedWord(.var), .identifier("test2"), .other(.equal), .number(12),
                // `if`
                .reservedWord(.if), .identifier("test"), .comparativeOperator(.less), .number(10), .curlyBlace(.left),
                .identifier("print"), .roundBlacket(.left), .identifier("test"), .roundBlacket(.right),
                // ` else`
                .curlyBlace(.right), .reservedWord(.else), .curlyBlace(.left),
                .identifier("print"), .roundBlacket(.left), .identifier("test2"), .roundBlacket(.right),
                .curlyBlace(.right),
                // `func`
                .reservedWord(.func), .identifier("testMethod"), .roundBlacket(.left), .roundBlacket(.right), .other(.arrow), .squareBlacket(.left), .identifier("Int"), .squareBlacket(.right), .curlyBlace(.left),
                // `return`
                .reservedWord(.return), .squareBlacket(.left), .number(10), .squareBlacket(.right),
                .curlyBlace(.right),
                // `enum`
                .reservedWord(.enum), .identifier("Hoge"), .curlyBlace(.left),
                // `case`
                .reservedWord(.case), .identifier("test1"),
                .reservedWord(.case), .identifier("test2"),
                .curlyBlace(.right),
                // `while`
                .reservedWord(.while), .identifier("test2"), .comparativeOperator(.less), .number(20), .curlyBlace(.left),
                .reservedWord(.if), .identifier("test2"), .other(.multiEqual), .number(5), .curlyBlace(.left),
                // `break`
                .reservedWord(.break),
                .curlyBlace(.right), .reservedWord(.else), .curlyBlace(.left),
                .identifier("test2"), .other(.plusEqual), .number(1),
                // `continue`
                .reservedWord(.continue),
                .curlyBlace(.right), .curlyBlace(.right),
                .other(.eof)
            ]
            
            let tokens = tokenize(input: sampleCode)
            print("tokens \(tokens.count), expected \(expected.count)")
            XCTAssertEqual(tokens.count, expected.count)
            XCTAssertEqual(tokens, expected)
            
        }
        
        XCTContext.runActivity(named: "other") { _ in
        }
    }
}
