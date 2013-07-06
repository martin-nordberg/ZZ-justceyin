
import org.justceyin.generations.fundamentals.lexing {
    Token
}

"Token representing a left bracket character ('[')."
shared interface LeftBracketToken
    satisfies Token {
    
    "The text of this token."
    shared actual String text => "[";
    
}
