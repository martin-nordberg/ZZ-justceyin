
import ceylon.collection { 
    HashMap 
}


"General purpose lexer."
shared abstract class Lexer<Language>( 
    {Recognizer<Language>+} recognizers 
)
    given Language satisfies Token
{
    Map<Character,{Recognizer<Language>+}> recognizersByStartingChar = assembleRecognizers( recognizers );
    
    shared Iterator<Language> lex( {Character*} input ) {
        return LexResult<Language>( this, this.recognizersByStartingChar, input );
    }
    
    shared formal Language unrecognizedCharacterToken( Character character );
}


Map<Character,{Recognizer<Language>+}> assembleRecognizers<Language>( {Recognizer<Language>+} recognizers )
    given Language satisfies Token {

    HashMap<Character,{Recognizer<Language>+}> result = HashMap<Character,{Recognizer<Language>+}>();

    for ( recognizer in recognizers ) {
        for ( ch in recognizer.startingCharacters ) {
            if ( exists r = result.get(ch) ) {
                result.put( ch, {recognizer,*result.get(ch)} );
            }
            else {
                result.put( ch, {recognizer} );
            }
        }
    }
    
    return result;
}

"Class representing the iterable result of lexing a given input."
class LexResult<Language>(
    "The associated lexer (used to build an unreognized characater token if needed."
    Lexer<Language> lexer,
    "The recognizers defining the lexer."
    Map<Character,{Recognizer<Language>+}> recognizersByStartingChar,
    "The input to be lexed."
    {Character*} input
)
    satisfies Iterator<Language>
    given Language satisfies Token
{
    "The input that reamins to be read."
    variable {Character*} remainingInput = input;
    
    "Return the next token from the lexer."
    shared actual Language|Finished next() {
        
        // skip whitespace
        while ( exists nextChar = remainingInput.first ) {
            if ( !nextChar.whitespace ) {
                break;
            }
        }
        
        // parse a token using one of the recognizers for the remaining input
        if ( exists nextChar = remainingInput.first ) {
            if ( exists recognizers = recognizersByStartingChar[nextChar] ) {
                for ( recognizer in recognizers ) {
                    value result = recognizer.recognize( remainingInput );
                    if ( exists result ) {
                        this.remainingInput = result[1];
                        return result.first;
                    }
                }
            }
            
            // unrecognized character in the input
            return lexer.unrecognizedCharacterToken( nextChar );
        }

        // input exhausted
        return finished;
    }
    
}
