//
//  main.swift
//  testSwiftCompiler
//
//  Created by Takeshi Komori on 2023/04/04.
//

enum Token {
    case number(Int)
    case identifier(String)
    case binaryOperator(BinaryOperatorType)
    case roundBlacket(RoundBlacketType)
    case curlyBlace(CurlyBlaceType)
    case squareBlacket(SquareBlacketType)
    case reservedWord(ReservedWordType)
    case arrow // `->`
    
    enum BinaryOperatorType {
        case plus // `+`
        case minus // `-`
        case asterisk // `*`
        case slash // `/`
        case percent // `%`
        case equal // `=`
    }
    
    enum RoundBlacketType {
        case left // `(`
        case right // `)`
    }
    
    enum CurlyBlaceType {
        case left // `{`
        case right // `}`
    }
    
    enum SquareBlacketType {
        case left // `[`
        case right // `]`
    }
    
    enum ReservedWordType {
        case `let`
        case `var`
        case `func`
        case `return`
        case `if`
        case `else`
        case `enum`
        case `case`
    }
}

func tokenize(str: String) -> [Token] {
    return []
}

func main() {
    let sourceCode = """
print(test())

func test() -> Int {
  return 10 + 5
}

"""
    let tokens = tokenize(str: sourceCode)
    print("終了")
}

main()
