
import ceylon.collection { 
    HashMap 
}
import org.justceyin.generations.fundamentals.scanning { 
    endOfInput, 
    Scanner
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
        value scanner = Scanner( 4, 4, input );
        
        while ( scanner.lookAhead( 0 ) != endOfInput ) {
            
            // consume white space
            while ( scanner.lookAhead( 0 ).character.whitespace ) {
                scanner.advance( 1 );
            }

            // get the first character of the next token
            value ch0 = scanner.lookAhead( 0 );

            // quit if end of input
            if ( ch0 == endOfInput ) {
                break;
            }

            // recognize a token
            this.recognizeToken( yield, scanner, ch0 );
        }
    }
    
    "Recognizes the next token from the input."
    void recognizeToken(
        "Callback function receives tokens recognized by the lexer."
        Anything(Token<Language>) yield,
        Scanner scanner,
        Scanner.ScannedCharacter lookAhead0
    ) {
        // look up the recognizers from the starting character
        if ( exists recognizers = this.recognizersByStartingChar[lookAhead0.character] ) {
            for ( recognizer in recognizers ) {
                switch ( recognizer )
                  case ( is String ) {
                    if ( this.recognizeString( recognizer, yield, scanner, lookAhead0 ) ) {
                        break;
                    }
                  }
                  case ( is TokenRecognizer<Language> ) {
                    // TBD: call recognizer   
                  }
            }
        }
        else {
            yield( UnrecognizedCharacterToken<Language>( lookAhead0.character ) );
            scanner.advance( 1 );
        }
    }
    
    Boolean recognizeString( 
        String tokenText,
        "Callback function receives tokens recognized by the lexer."
        Anything(Token<Language>) yield,
        Scanner scanner,
        Scanner.ScannedCharacter lookAhead0
    ) {
       Integer i = 1;
       while ( i < tokenText.size ) {
           assert ( exists ch = tokenText[i] );
           if ( ch != scanner.lookAhead(i).character ) {
                return false;
           }
       }
       
       yield( /*TBD*/ );
       
       return true;
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

