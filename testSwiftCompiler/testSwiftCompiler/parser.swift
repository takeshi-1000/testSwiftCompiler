//
//  parser.swift
//  testSwiftCompiler
//
//  Created by Takeshi Komori on 2023/04/04.
//

/*
 SourceFile

 TopLevelCodeDecl
 ImportDecl
 Decl
 ValueDecl
 VarDecl
 PatternBinding
 Pattern
 TypeAnnotation
 Initializer
 Expr
 FuncDecl
 Identifier
 Signature
 ParameterList
 Parameter
 Identifier
 TypeAnnotation
 Result
 TypeAnnotation
 GenericWhereClause
 GenericParameterList
 Body
 Expr
 EnumDecl
 ClassDecl
 StructDecl
 ProtocolDecl
 ExtensionDecl
 TypeAliasDecl
 OperatorDecl
 */

/*
 - Source
   - Statement
     - FunctionCall(name: "print")
       - Argument(label: nil, value: FunctionCall(name: "test"))
         - Argument(label: nil, value: nil)
   - Decl
     - FunctionDecl(name: "test", returnType: "Int")
       - Statement
         - BinaryOp(op: +)
           - LiteralExpr(value: 10)
           - LiteralExpr(value: 5)
 */

/*
 SourceFile: Swiftコード全体を表すノード
 FunctionDecl: 関数宣言を表すノード
 StructDecl: 構造体宣言を表すノード
 ClassDecl: クラス宣言を表すノード
 EnumDecl: 列挙型宣言を表すノード
 ProtocolDecl: プロトコル宣言を表すノード
 ExtensionDecl: 拡張宣言を表すノード
 IfStmt: if文を表すノード
 GuardStmt: guard文を表すノード
 WhileStmt: while文を表すノード
 RepeatWhileStmt: do-while文を表すノード
 ForInStmt: for-in文を表すノード
 SwitchStmt: switch文を表すノード
 DoStmt: do文を表すノード
 BraceStmt: ブロック文を表すノード
 ReturnStmt: return文を表すノード
 ThrowStmt: throw文を表すノード
 DeferStmt: defer文を表すノード
 AssignmentExpr: 代入式を表すノード
 BinaryExpr: 二項演算式を表すノード
 UnaryExpr: 単項演算式を表すノード
 FunctionCallExpr: 関数呼び出し式を表すノード
 SubscriptExpr: サブスクリプト式を表すノード
 TupleExpr: タプル式を表すノード
 ClosureExpr: クロージャ式を表すノード
 IdentifierExpr: 識別子を表すノード
 LiteralExpr: リテラルを表すノード
 */

// Exprは値を返す

/*
 Root
 └── Statements
     ├── AssignmentStatement
     │   ├── VariableIdentifierExpr(a)
     │   └── LiteralExpr(10)
     └── AssignmentStatement
         ├── VariableIdentifierExpr(b)
         └── BinaryExpr(+)
             ├── VariableIdentifierExpr(a)
             └── LiteralExpr(5)
 */

struct AST {
    let statments: [Statement]
    let declations: [Declaration]
}

protocol Declaration {}
protocol Statement {}
protocol Expr {}

// MARK: Statement

struct FunctionCallStatement: Statement {
    let functionName: String
    let arguments: [Expr]
    let returnType: String?
}

struct VariableAssingmentStatement: Statement {
    let name: String
    let value: Expr
}

struct LetAssingmentStatment: Statement {
    let name: String
    let value: Expr
}

struct ReturnValueStatement: Statement {
    let value: Expr
}

struct IfStatement: Statement {
    let condition: Expr
    let body: [Statement]
    let elseBody: [Statement]
}

struct SwitchStatement: Statement {
    let caseStetements: [SwitchCaseStatement]
    let defaultStetements: [Statement]
    
    struct SwitchCaseStatement {
        let condition: Expr
        let body: [Statement]
    }
}

// MARK: Declaration

struct FunctionDeclaration: Declaration {
    let name: String
    let arguments: [String : String]
    let body: [Statement]
    let returnValue: Expr
}

struct EnumDeclaration: Declaration {
    let name: String
    let cases: [CaseDeclaration]
    
    struct CaseDeclaration {
        let name: String
        let argments: [String : String]?
    }
}

// MARK: Expr
struct VariableExpr: Expr {
    var name: String
}

struct IntLiteralExpr: Expr {
    var value: Int
}

struct BinaryAddExpr: Expr {
    var left: Expr
    var right: Expr
}

struct BinaryMultiExpr: Expr {
    var left: Expr
    var right: Expr
}

struct CompareExpr: Expr {
    var left: Expr
    var right: Expr
    var type: CompareType
    
    enum CompareType {
        case equal
    }
}

struct FunctionCallExpr: Expr {
    var functionName: String
    var arguments: [Expr]
    var returnType: String
}

struct EnumValueExpr: Expr {
    var name: String
    var arguments: [Expr]
    var returnType: String?
}

/*
 .reservedWord(.let), .identifier("test"), .other(.equal), .number(5),
 .reservedWord(.if), .identifier("test"), .other(.multiEqual), .number(5), .curlyBlace(.left),
 .identifier("print"), .roundBlacket(.RoundBlacketType.left), .identifier("test"), .roundBlacket(.RoundBlacketType.right),
 .curlyBlace(.CurlyBlaceType.right), .reservedWord(..else), .curlyBlace(.CurlyBlaceType.left),
 .identifier("print"), .roundBlacket(.RoundBlacketType.left), .number(4), .roundBlacket(.RoundBlacketType.right),
 .curlyBlace(.CurlyBlaceType.right),
 .other(.eof)
 
 if test == 5 {
   print(test)
 } else {
   print(4)
 }
 */

// TODO: throw関数にする
func parse(tokens: [Token]) -> AST  {
//
//    let declarations: [Declaration] = [
//        EnumDeclaration(name: "Hoge",
//                        cases: [
//                            EnumDeclaration.CaseDeclaration(name: "test1"),
//                            EnumDeclaration.CaseDeclaration(name: "test2"),
//                        ])
//    ]
//
//    let statements: [Statement] = [
        /*
         var test0 = 4
         let test = 5
         if test == 5 {
           print(test)
         } else {
           print(4)
         }
         
         enum Hoge {
           case test1
           case test2
         }
         
         let hoge: Hoge = .test1
         
         switch case hoge {
          case .test1:
         
          case .test2:
           
         }
         
         */
//        LetAssingmentStatment(name: "test0",
//                              value: IntLiteralExpr(value: 4)),
//        LetAssingmentStatment(name: "test",
//                              value: IntLiteralExpr(value: 5)),
//        IfStatement(
//            condition: CompareExpr(left: VariableExpr(name: "test"),
//                                   right: IntLiteralExpr(value: 5),
//                                   type: .equal),
//            body: [
//                FunctionCallStatement(
//                    functionName: "print",
//                    arguments: [
//                        VariableExpr(name: "test")
//                    ]
//                )
//            ],
//            elseBody: [
//                FunctionCallStatement(
//                    functionName: "print",
//                    arguments: [
//                        IntLiteralExpr(value: 4)
//                    ]
//                )
//            ]
//        ),
//
//        LetAssingmentStatment(name: "hoge",
//                              value: EnumValueExpr(name: "test1"),
//                              returnType: "Hoge"),
//
//        SwitchStatement(caseStetements: [
//            SwitchStatement
//                .SwitchCaseStatement(condition: CompareExpr(left: VariableExpr(name: "hoge"),
//                                                            right: EnumValueExpr(name: "hoge1",
//                                                                                 arguments: [],
//                                                                                 returnType: nil),
//                                                            type: .equal),
//                                     body: [
//
//                                     ]),
//            SwitchStatement
//                .SwitchCaseStatement(condition: CompareExpr(left: VariableExpr(name: "hoge"),
//                                                            right: EnumValueExpr(name: "hoge1",
//                                                                                 arguments: [],
//                                                                                 returnType: nil),
//                                                            type: .equal),
//                                     body: [
//
//                                     ])],
//                        defaultStetements: [
//                        ])
//    ]
    
    
    var ast = AST(statments: [],
                  declations: [])
    
    var statements: [Statement] = []
    
    var currentIndex = 0

    while currentIndex < tokens.count {
        
        let currentToken: Token = tokens[currentIndex]
        
        switch currentToken {
        case .identifier(let string): // 関数呼び出し
            continue
        case .reservedWord(let reservedWordType): // 宣言 or 実際の処理
            switch reservedWordType {
            case .let:
                guard
                    case let .identifier(identifierValue) = tokens[currentIndex + 1],
                    case let .number(numberValue) = tokens[currentIndex + 3]
                else {
                    return ast
                }
                let statment = LetAssingmentStatment(name: identifierValue, value: IntLiteralExpr(value: numberValue))
                statements.append(statment)
                
            case .var:
                guard
                    case let .identifier(identifierValue) = tokens[currentIndex + 1],
                    case let .number(numberValue) = tokens[currentIndex + 3]
                else {
                    return ast
                }
                let statment = VariableAssingmentStatement(name: identifierValue, value: IntLiteralExpr(value: numberValue))
                statements.append(statment)
                
            case .func:
                break
            case .return:
                break
            case .if:
                break
            case .else:
                break
            case .enum:
                break
            case .`case`:
                break
            case .continue:
                break
            case .break:
                break
            case .while:
                break
            }
        default: break
        }
        
    }
    
    return ast
}
