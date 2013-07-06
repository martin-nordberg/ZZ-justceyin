
import org.justceyin.generations.fundamentals.lexing {
    Token
}

"Token representing a left brace character ('{')."
shared interface LeftBraceToken
    satisfies Token {
    
    "The text of this token."
    shared actual String text => "{";
    
}
