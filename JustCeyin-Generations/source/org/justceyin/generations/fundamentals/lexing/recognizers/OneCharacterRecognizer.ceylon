
import org.justceyin.expectations { 
    constrain 
}
import org.justceyin.expectations.constraints.providers { 
    aString 
}
import org.justceyin.generations.fundamentals.lexing {
    Recognizer,
    Token
}

"Recognizer for a one-character fixed text token."
shared class OneCharacterRecognizer<Language,T>(
    "The single token recognized by this recognizer."
    T token
)
    satisfies Recognizer<Language>
    given Language satisfies Token
    given T satisfies Language
{
    constrain( token.text ).named( "token" ).toBe( aString.withLength(1) );
    
    Character character;
    assert ( exists ch = token.text[0] );
    character = ch;
    
    "The displayable name of the recognized token for lexer messages."
    shared actual String name => "'``token.text``'";

    "Recognizes a token with known starting character."
    shared actual [Language,{Character*}]? recognize( {Character*} input ) {
        assert ( exists ch = input.first );
        assert ( ch == character );
        return [this.token,input.rest];
    }

    "The characters that could potentially start tokens recognized by this recognizer."
    shared actual [Character] startingCharacters => [character];
    
}
