
import org.justceyin.generations.fundamentals.lexing {
    Recognizer,
    BaseToken = Token
}

"Recognizer for a one-character fixed text token."
shared abstract class OneCharacterRecognizer(
    "The single charcater of the token recognized by this recognizer."
    Character character
)
    satisfies Recognizer
{
    "Member class representing the token recognized by this recognizer."
    shared formal class Token()
        satisfies BaseToken
    {
        "The text of the token (exactly as recognized by the lexer)."
        shared actual String text => outer.character.string;
    }
    
    "The immutable token recognized by this recognizer."
    Token token = Token();

    "The displayable name of the recognized token for lexer messages."
    shared actual String name => "'``this.character``'";

    "Recognizes a token with known starting character."
    shared actual [Token,{Character*}]? recognize( {Character*} input ) {
        assert ( exists ch = input.first );
        assert ( ch == this.character );
        return [ this.token, input.rest ];
    }

    "The characters that could potentially start tokens recognized by this recognizer."
    shared actual [Character] startingCharacters = [this.character];

}
