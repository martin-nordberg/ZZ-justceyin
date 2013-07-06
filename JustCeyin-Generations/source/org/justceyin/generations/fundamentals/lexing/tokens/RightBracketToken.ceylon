
import org.justceyin.generations.fundamentals.lexing {
    Token
}

"Token representing a right bracket character (']')."
shared interface RightBracketToken
    satisfies Token {
    
    "The text of this token."
    shared actual String text => "}";
    
}
