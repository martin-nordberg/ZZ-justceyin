
import org.justceyin.generations.fundamentals.lexing {
    Token
}

"Token representing a right brace character ('}')."
shared interface RightBraceToken
    satisfies Token {
    
    "The text of this token."
    shared actual String text => "}";
    
}
