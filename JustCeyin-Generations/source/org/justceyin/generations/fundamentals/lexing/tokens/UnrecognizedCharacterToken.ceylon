
import org.justceyin.generations.fundamentals.lexing {
    Token
}

"Token representing an unrecognized character in the input."
shared class UnrecognizedCharacterToken( Character char )
    satisfies Token {
    
    "The text of this token."
    shared actual String text => "Unrecognized character: '``char``'";
    
}
