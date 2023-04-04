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
        case `continue`
        case `break`
    }
}

func tokenize(input: String) -> [Token] {
    var tokens: [Token] = []
    var position = input.startIndex
    
    while position < input.endIndex {
        let currentChar = input[position]
        
        if currentChar.isWhitespace {
            position = input.index(after: position)
            continue
        }
        
        switch currentChar {
            
        case "0"..."9":
            var numberStr = ""
            var currentNumberStrPoistion = position
            
            while currentNumberStrPoistion < input.endIndex {
                let _currentCharacter = input[currentNumberStrPoistion]
                
                if _currentCharacter.isNumber {
                    numberStr.append(_currentCharacter)
                } else {
                    break
                }
                
                currentNumberStrPoistion = input.index(after: currentNumberStrPoistion)
            }
            
            tokens.append(.number(Int(numberStr)!))
            position = input.index(after: currentNumberStrPoistion)
            
        case "+":
            tokens.append(.binaryOperator(.plus))
            position = input.index(after: position)
            
        case "-":
            position = input.index(after: position)
            
            let _currentChar = input[position]
            
            // -> を考慮して
            if _currentChar == ">" {
                tokens.append(.arrow)
                position = input.index(after: position)
                
            } else {
                tokens.append(.binaryOperator(.minus))
                
            }
        
        case "*":
            tokens.append(.binaryOperator(.asterisk))
            position = input.index(after: position)
            
        case "/":
            tokens.append(.binaryOperator(.slash))
            position = input.index(after: position)
            
        case "%":
            tokens.append(.binaryOperator(.percent))
            position = input.index(after: position)
            
        case "=":
            tokens.append(.binaryOperator(.equal))
            position = input.index(after: position)
            
        case "{":
            tokens.append(.curlyBlace(.left))
            position = input.index(after: position)
            
        case "}":
            tokens.append(.curlyBlace(.right))
            position = input.index(after: position)
            
        case "[":
            tokens.append(.squareBlacket(.left))
            position = input.index(after: position)
            
        case "]":
            tokens.append(.squareBlacket(.right))
            position = input.index(after: position)
            
        case "(":
            tokens.append(.roundBlacket(.left))
            position = input.index(after: position)
            
        case ")":
            tokens.append(.roundBlacket(.right))
            position = input.index(after: position)
            
        default:
            var identifier = ""
            var currentIdentifierPoistion = position
            
            while currentIdentifierPoistion < input.endIndex {
                let _currentCharacter = input[currentIdentifierPoistion]
                
                if _currentCharacter.isLetter || _currentCharacter.isNumber || _currentCharacter == "_" {
                    identifier.append(_currentCharacter)
                } else {
                    break
                }
                
                currentIdentifierPoistion = input.index(after: currentIdentifierPoistion)
            }
            
            switch identifier {
                
            case "let":
                tokens.append(.reservedWord(.let))
                position = input.index(after: currentIdentifierPoistion)
                
            case "var":
                tokens.append(.reservedWord(.var))
                position = input.index(after: currentIdentifierPoistion)
                
            case "func":
                tokens.append(.reservedWord(.func))
                position = input.index(after: currentIdentifierPoistion)
                
            case "return":
                tokens.append(.reservedWord(.return))
                position = input.index(after: currentIdentifierPoistion)
                
            case "if":
                tokens.append(.reservedWord(.if))
                position = input.index(after: currentIdentifierPoistion)
                
            case "else":
                tokens.append(.reservedWord(.else))
                position = input.index(after: currentIdentifierPoistion)
                
            case "enum":
                tokens.append(.reservedWord(.enum))
                position = input.index(after: currentIdentifierPoistion)
                
            case "case":
                tokens.append(.reservedWord(.case))
                position = input.index(after: currentIdentifierPoistion)
                
            case "continue":
                tokens.append(.reservedWord(.continue))
                position = input.index(after: currentIdentifierPoistion)
                
            case "break":
                tokens.append(.reservedWord(.break))
                position = input.index(after: currentIdentifierPoistion)
                
            default:
                tokens.append(.identifier(identifier))
                position = input.index(after: currentIdentifierPoistion)
            }
        }
    }
    
    return tokens
}

func main() {
    let sourceCode = """
print(test())

func test() -> Int {
  return 10 + 5
}

"""
    let tokens = tokenize(input: sourceCode)
    print("tokens: \(tokens)")
    print("終了")
}

main()
