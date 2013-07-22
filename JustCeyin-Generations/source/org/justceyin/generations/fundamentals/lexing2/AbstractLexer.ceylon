
import ceylon.collection { 
    HashMap 
}

shared abstract class AbstractLexer<Language>(
    {String|TokenRecognizer<Language>+} recognizers
)
    satisfies Lexer<Language>
{
    
    // TBD: construct a tree-structured recognizer look up that uses the first three characters of a token
    Map<Character,{String|TokenRecognizer<Language>+}> recognizersByStartingChar = 
        assembleRecognizers( recognizers );
    
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
                    // TBD
                }
                else {
                    // TBD: unrecognized char
                }
            }
        }
    }

}

"Helper function maps recognizers by their starting character."
Map<Character,{String|TokenRecognizer<Language>+}> assembleRecognizers<Language>( 
    {String|TokenRecognizer<Language>+} recognizers 
) {

    HashMap<Character,{String|TokenRecognizer<Language>+}> result = 
        HashMap<Character,{String|TokenRecognizer<Language>+}>();

    for ( recognizer in recognizers ) {
        switch ( recognizer )
          case ( is String ) {
              assert( exists ch = recognizer[0] );
              if ( exists r = result.get(ch) ) {
                  result.put( ch, {recognizer,*r} );
              }
              else {
                  result.put( ch, {recognizer} );
              }
          }
          case ( is TokenRecognizer<Language> ) {
              for ( ch in recognizer.startingCharacters ) {
                  if ( exists r = result.get(ch) ) {
                      result.put( ch, {recognizer,*r} );
                  }
                  else {
                      result.put( ch, {recognizer} );
                  }
              }
          }
    }
    
    return result;
}

