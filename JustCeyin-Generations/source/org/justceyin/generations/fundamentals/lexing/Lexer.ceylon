
import ceylon.collection { 
    HashMap 
}


"General purpose lexer."
shared abstract class Lexer<Language>( 
    {Recognizer<Language>+} recognizers 
)
{
    Map<Character,{Recognizer<Language>+}> recognizersByStartingChar = assembleRecognizers( recognizers );
    
    shared Iterator<Token<Language>> lex( {Character*} input ) {
        return LexResult( this, this.recognizersByStartingChar, input );
    }

}

"Helper function maps recognizers by their strating character."
Map<Character,{Recognizer<Language>+}> assembleRecognizers<Language>( {Recognizer<Language>+} recognizers ) {

    HashMap<Character,{Recognizer<Language>+}> result = HashMap<Character,{Recognizer<Language>+}>();

    for ( recognizer in recognizers ) {
        for ( ch in recognizer.startingCharacters ) {
            if ( exists r = result.get(ch) ) {
                result.put( ch, {recognizer,*r} );
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
    satisfies Iterator<Token<Language>>
{
    "The input that reamins to be read."
    variable {Character*} remainingInput = input;
    
    "Return the next token from the lexer."
    shared actual Token<Language>|Finished next() {
        
        // skip whitespace
        while ( exists nextChar = remainingInput.first /*&& nextChar.whitespace*/ ) {
            if ( !nextChar.whitespace ) {
                break;
            }
            remainingInput = remainingInput.rest;
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
            return UnrecognizedCharacterToken<Language>( nextChar );
        }

        // input exhausted
        return finished;
    }
    
}
