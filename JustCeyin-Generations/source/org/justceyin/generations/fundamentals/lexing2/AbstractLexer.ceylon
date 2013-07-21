
import ceylon.collection { 
    HashMap 
}

shared abstract class AbstractLexer<Language>(
    {TokenRecognizer<Language>+} recognizers
)
    satisfies Lexer<Language>
{
    
    // TBD: construct a tree-structured recognizer look up that uses the first three characters of a token
    Map<Character,{TokenRecognizer<Language>+}> recognizersByStartingChar = assembleRecognizers( recognizers );
    
    shared actual void lex(
        "Callback function receives tokens recognized by the lexer."
        Anything(Token<Language>) yield,
        "The input to be lexed."
        Iterator<Character> input
    ) {
        variable Character|Finished inputChar = input.next();
        while ( inputChar != finished ) {
            
            // consume white space
            while ( is Character ch = inputChar ) {
                if ( !ch.whitespace ) {
                    break;
                }
                inputChar = input.next();
            }

            // recognize a token
            if ( is Character ch1 = inputChar ) {

                // recognize a token
                if ( exists recognizers = recognizersByStartingChar[ch1] ) {

                    while ( is Character ch = inputChar ) {
                        for ( recognizer in recognizers ) {
                            if ( recognizer.recognize( yield, ch ) ) {
                                break;
                            }
                        }
                        else {
                            inputChar = input.next();
                        }
                    }
                }
                else {
                    // TBD: unrecognized char
                }
            }
        }
    }

}

"Helper function maps recognizers by their starting character."
Map<Character,{TokenRecognizer<Language>+}> assembleRecognizers<Language>( {TokenRecognizer<Language>+} recognizers ) {

    HashMap<Character,{TokenRecognizer<Language>+}> result = HashMap<Character,{TokenRecognizer<Language>+}>();

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

