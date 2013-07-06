
import org.justceyin.specifications {
    ImperativeSpecification
}
import org.justceyin.expectations.constraints { 
    Constraint, 
    ConstraintCheckFailure, 
    ConstraintCheckResult, 
    ConstraintCheckSuccess 
}
import org.justceyin.expectations { 
    expect 
}
import org.justceyin.generations.fundamentals.lexing {
    Lexer, 
    Token
}
import org.justceyin.generations.fundamentals.lexing.tokens { 
    LeftBraceToken, 
    RightBraceToken, 
    UnrecognizedCharacterToken 
}
import org.justceyin.generations.fundamentals.lexing.recognizers { 
    OneCharacterRecognizer 
}
    

shared interface BracyLanguage
    of BracyLeftBraceToken | BracyRightBraceToken | BracyUnrecognizedCharacterToken
    satisfies Token
{
}
    
shared class BracyLeftBraceToken()
    satisfies BracyLanguage & LeftBraceToken
{
}

shared class BracyRightBraceToken()
    satisfies BracyLanguage & RightBraceToken
{
}

shared class BracyUnrecognizedCharacterToken( Character character )
    extends UnrecognizedCharacterToken( character )
    satisfies BracyLanguage 
{
}

shared class BracyLeftBraceRecognizer( )
    extends OneCharacterRecognizer<BracyLanguage,BracyLeftBraceToken>( BracyLeftBraceToken() )
{
}

shared class BracyRightBraceRecognizer( )
    extends OneCharacterRecognizer<BracyLanguage,BracyRightBraceToken>( BracyRightBraceToken() )
{
}

shared object bracyLexer
    extends Lexer<BracyLanguage>( { BracyLeftBraceRecognizer(), BracyRightBraceRecognizer() } ) {
    
    shared actual BracyLanguage unrecognizedCharacterToken( Character character ) {
        return BracyUnrecognizedCharacterToken( character );
    }
}
   
shared object aToken {
 
    shared class TokenTextConstraint(
        String expectedTokenText
    )
        satisfies Constraint<BracyLanguage|Finished>
    {
        
        "Applies the constraint by calling the predicate and then computing the message according to the outcome."
        shared actual ConstraintCheckResult check( 
            "The actual value (or comparable value) to compare against."
            BracyLanguage|Finished actualValue, 
            "The name of the value for use in the output message."
            String valueName 
        ) {
            if ( is BracyLanguage actualValue ) {
                if ( actualValue.text == expectedTokenText ) {
                    return ConstraintCheckSuccess( "Verified ``valueName`` to be a token with text ``expectedTokenText``." );
                }
                return ConstraintCheckFailure( "Expected ``valueName`` to be a token with text ``expectedTokenText`` but was ``actualValue``." );
            }
            return ConstraintCheckFailure( "Expected ``valueName`` to be a token with text ``expectedTokenText`` but was nonexistent." );
        }
    
    }         

    "Returns a constraint that checks that an actual value equals an expected value."
    shared Constraint<BracyLanguage|Finished> withText(
        "The value that test values are expected to be equal to." 
        String expectedValue 
    ) {
        return TokenTextConstraint( expectedValue );
    }
}


"Specification exercises a Lexer implementation."
by "Martin E. Nordberg III"
shared class LexerSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "Lexer Specification";

    "A lexer made of single-character recognizers lexes a string of those characters."
    void testOneCharacterLexer( void outcomes( ConstraintCheckResult* results ) ) {
        String input = "{}{}{}";
        
        value tokens = bracyLexer.lex( input.sequence );
            
        outcomes( 
            expect( tokens.next() ).named( "first token" ).toBe( aToken.withText( "{" ) ),
            expect( tokens.next() ).named( "second token" ).toBe( aToken.withText( "}" ) ),
            expect( tokens.next() ).named( "third token" ).toBe( aToken.withText( "{" ) ),
            expect( tokens.next() ).named( "fourth token" ).toBe( aToken.withText( "}" ) ),
            expect( tokens.next() ).named( "fifth token" ).toBe( aToken.withText( "{" ) ),
            expect( tokens.next() ).named( "sixth token" ).toBe( aToken.withText( "}" ) )
        );
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testOneCharacterLexer
    };

}
