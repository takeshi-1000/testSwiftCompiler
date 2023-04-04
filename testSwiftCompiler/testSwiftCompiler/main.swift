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
    case other(OtherType)
    
    enum BinaryOperatorType {
        case plus // `+`
        case minus // `-`
        case asterisk // `*`
        case slash // `/`
        case percent // `%`
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
        case `while`
    }
    
    enum OtherType {
        case equal // `=`
        case comma // `,`
        case period // `.`
        case multiEqual // `==`
        case plusEqual // `+=`
        case arrow // `->`
        case colon // `:`
        case eof
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
                tokens.append(.other(.arrow))
                position = input.index(after: position)
                
            } else {
                tokens.append(.binaryOperator(.minus))
                
            }
        
        case "*":
            tokens.append(.binaryOperator(.asterisk))
            position = input.index(after: position)
            
        case "/":
            position = input.index(after: position)
            
            let _currentChar = input[position]
            // //(コメントアウト) を考慮して
            if _currentChar == "/" {
                var endOfCommentOutPosition = position
                
                while endOfCommentOutPosition < input.endIndex {
                    if input[endOfCommentOutPosition] == "\n" {
                        break
                    }
                    endOfCommentOutPosition = input.index(after: endOfCommentOutPosition)
                }
                position = input.index(after: endOfCommentOutPosition)
                
            } else {
                tokens.append(.binaryOperator(.slash))
            }
            
        case "%":
            tokens.append(.binaryOperator(.percent))
            position = input.index(after: position)
            
        case "=":
            position = input.index(after: position)
            
            let _currentChar = input[position]
            
            // == を考慮して
            if _currentChar == "=" {
                tokens.append(.other(.multiEqual))
                position = input.index(after: position)
                
            } else {
                tokens.append(.other(.equal))
            }
            
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
            
        case ":":
            tokens.append(.other(.colon))
            position = input.index(after: position)
            
        case ",":
            tokens.append(.other(.comma))
            position = input.index(after: position)
            
        case ".":
            tokens.append(.other(.period))
            position = input.index(after: position)
            
        default:
            var identifier = ""
            var currentIdentifierPoistion = position
            
            while currentIdentifierPoistion < input.endIndex {
                let _currentCharacter = input[currentIdentifierPoistion]
                
                if _currentCharacter.isLetter || _currentCharacter.isNumber || _currentCharacter == "_" {
                    identifier.append(_currentCharacter)
                    currentIdentifierPoistion = input.index(after: currentIdentifierPoistion)
                } else {
                    break
                }
            }
            
            switch identifier {
                
            case "let":
                tokens.append(.reservedWord(.let))
                position = currentIdentifierPoistion
                
            case "var":
                tokens.append(.reservedWord(.var))
                position = currentIdentifierPoistion
                
            case "func":
                tokens.append(.reservedWord(.func))
                position = currentIdentifierPoistion
                
            case "return":
                tokens.append(.reservedWord(.return))
                position = currentIdentifierPoistion
                
            case "if":
                tokens.append(.reservedWord(.if))
                position = currentIdentifierPoistion
                
            case "else":
                tokens.append(.reservedWord(.else))
                position = currentIdentifierPoistion
                
            case "enum":
                tokens.append(.reservedWord(.enum))
                position = currentIdentifierPoistion
                
            case "case":
                tokens.append(.reservedWord(.case))
                position = currentIdentifierPoistion
                
            case "continue":
                tokens.append(.reservedWord(.continue))
                position = currentIdentifierPoistion
                
            case "break":
                tokens.append(.reservedWord(.break))
                position = currentIdentifierPoistion
            
            case "while":
                tokens.append(.reservedWord(.while))
                position = currentIdentifierPoistion
                
            default:
                tokens.append(.identifier(identifier))
                position = currentIdentifierPoistion
                
            }
        }
    }
    
    tokens.append(.other(.eof))
    
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
