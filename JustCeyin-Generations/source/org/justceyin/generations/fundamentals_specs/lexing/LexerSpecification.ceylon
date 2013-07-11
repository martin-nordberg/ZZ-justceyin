
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
import org.justceyin.generations.fundamentals.lexing.recognizers {
    Colon,
    DoubleColon,
    LeftBrace, 
    RightBrace
}
    
shared class BraceLanguage() {}
    
shared object braceLexer
    extends Lexer<BraceLanguage>( { 
        LeftBrace<BraceLanguage>(), 
        RightBrace<BraceLanguage>() 
    } ) 
{
}

shared class ColonLanguage() {}

shared object colonLexer
    extends Lexer<ColonLanguage>( {
        Colon<ColonLanguage>(),
        DoubleColon<ColonLanguage>()
    } )
{
}

shared class AToken<Language>() {
 
    shared class TokenTextConstraint(
        String expectedTokenText
    )
        satisfies Constraint<Token<Language>|Finished>
    {
        
        "Applies the constraint by calling the predicate and then computing the message according to the outcome."
        shared actual ConstraintCheckResult check( 
            "The actual value (or comparable value) to compare against."
            Token<Language>|Finished actualValue, 
            "The name of the value for use in the output message."
            String valueName 
        ) {
            if ( is Token<Language> actualValue ) {
                if ( actualValue.text == expectedTokenText ) {
                    return ConstraintCheckSuccess( "Verified ``valueName`` to be a token with text ``expectedTokenText``." );
                }
                return ConstraintCheckFailure( "Expected ``valueName`` to be a token with text ``expectedTokenText`` but was ``actualValue.text``." );
            }
            return ConstraintCheckFailure( "Expected ``valueName`` to be a token with text ``expectedTokenText`` but was nonexistent." );
        }
    
    }         

    "Returns a constraint that checks that an actual value equals an expected value."
    shared Constraint<Token<Language>|Finished> withText(
        "The value that test values are expected to be equal to." 
        String expectedValue 
    ) {
        return TokenTextConstraint( expectedValue );
    }
}

object aBraceToken extends AToken<BraceLanguage>() {}
    
object aColonToken extends AToken<ColonLanguage>() {}
    


"Specification exercises a Lexer implementation."
by "Martin E. Nordberg III"
shared class LexerSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "Lexer Specification";

    "A lexer made of single-character recognizers lexes a string of those characters."
    void testOneCharacterLexer( void outcomes( ConstraintCheckResult* results ) ) {
        String input = "{}{}{}";
        
        value tokens = braceLexer.lex( input.sequence );
            
        outcomes( 
            expect( tokens.next() ).named( "first token" ).toBe( aBraceToken.withText( "{" ) ),
            expect( tokens.next() ).named( "second token" ).toBe( aBraceToken.withText( "}" ) ),
            expect( tokens.next() ).named( "third token" ).toBe( aBraceToken.withText( "{" ) ),
            expect( tokens.next() ).named( "fourth token" ).toBe( aBraceToken.withText( "}" ) ),
            expect( tokens.next() ).named( "fifth token" ).toBe( aBraceToken.withText( "{" ) ),
            expect( tokens.next() ).named( "sixth token" ).toBe( aBraceToken.withText( "}" ) )
        );
    }
    
    "A lexer ignores whitespace."
    void testWhitespaceRemoval( void outcomes( ConstraintCheckResult* results ) ) {
        String input = " { }\n{\r\n}\t{\f}\r\n";
        
        value tokens = braceLexer.lex( input.sequence );
            
        outcomes( 
            expect( tokens.next() ).named( "first token" ).toBe( aBraceToken.withText( "{" ) ),
            expect( tokens.next() ).named( "second token" ).toBe( aBraceToken.withText( "}" ) ),
            expect( tokens.next() ).named( "third token" ).toBe( aBraceToken.withText( "{" ) ),
            expect( tokens.next() ).named( "fourth token" ).toBe( aBraceToken.withText( "}" ) ),
            expect( tokens.next() ).named( "fifth token" ).toBe( aBraceToken.withText( "{" ) ),
            expect( tokens.next() ).named( "sixth token" ).toBe( aBraceToken.withText( "}" ) )
        );
    }
    
    "A lexer recognizes tokens in the reverse of the order they are given to its constructor."
    void testTwoCharacterLexer( void outcomes( ConstraintCheckResult* results ) ) {
        String input = "::: : :::";
        
        value tokens = colonLexer.lex( input.sequence );
            
        outcomes( 
            expect( tokens.next() ).named( "first token" ).toBe( aColonToken.withText( "::" ) ),
            expect( tokens.next() ).named( "second token" ).toBe( aColonToken.withText( ":" ) ),
            expect( tokens.next() ).named( "third token" ).toBe( aColonToken.withText( ":" ) ),
            expect( tokens.next() ).named( "fourth token" ).toBe( aColonToken.withText( "::" ) ),
            expect( tokens.next() ).named( "fifth token" ).toBe( aColonToken.withText( ":" ) )
        );
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testOneCharacterLexer,
        testWhitespaceRemoval,
        testTwoCharacterLexer
    };

}
