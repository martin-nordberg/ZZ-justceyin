
import org.justceyin.generations.fundamentals.lexing {
    Recognizer,
    BaseToken = Token
}
import org.justceyin.expectations { 
    constrain 
}
import org.justceyin.expectations.constraints.providers { 
    aString 
}

"Recognizer for a two-character fixed text token."
shared abstract class TwoCharacterRecognizer<Language>(
    "The two character token recognized by this recognizer."
    String tokenText
)
    satisfies Recognizer<Language>
{
    constrain( tokenText ).toBe( aString.withLength( 2 ) );
    
    Character character1 = tokenText[0] else ' ';
    Character character2 = tokenText[1] else ' ';
    
    "Member class representing the token recognized by this recognizer."
    shared formal class Token()
        satisfies BaseToken<Language>
    {
        "The text of the token (exactly as recognized by the lexer)."
        shared actual String text = tokenText;
    }
    
    "The immutable token recognized by this recognizer."
    Token token = Token();

    "The displayable name of the recognized token for lexer messages."
    shared actual String name => "'``this.tokenText``'";

    "Recognizes a token with known starting character."
    shared actual [Token,{Character*}]? recognize( {Character*} input ) {
        assert ( exists ch1 = input.first );
        assert ( ch1 == this.character1 );
        if ( exists ch2 = input.rest.first ) {
            if ( ch2 == this.character2 ) { 
                return [ this.token, input.rest.rest ];
            }
        }
        return null;
    }

    "The characters that could potentially start tokens recognized by this recognizer."
    shared actual [Character] startingCharacters = [this.character1];

}
