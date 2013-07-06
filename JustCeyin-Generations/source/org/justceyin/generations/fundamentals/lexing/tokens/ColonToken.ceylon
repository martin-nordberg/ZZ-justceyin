
import org.justceyin.generations.fundamentals.lexing {
    Token
}

"Token representing a colon character."
shared interface ColonToken
    satisfies Token {
    
    "The text of this token."
    shared actual String text => ":";
    
}
