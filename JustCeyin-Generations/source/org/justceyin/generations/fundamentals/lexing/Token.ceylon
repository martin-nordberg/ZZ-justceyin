
"Base interface to token output by a lexer."
shared interface Token {
    
    "The text of the token (exactly as recognized by the lexer)."
    shared formal String text;
    
}


// FRAMEWORK INTERFACE

shared interface LexerRule<Language> 
    given Language satisfies Token 
{
    "Recognizes a token if possible."
    shared formal [Language,{Character*}]? recognize( {Character*} input );
}

shared class Lexxer<Language>( {LexerRule<Language>*} rules ) 
    given Language satisfies Token 
{
    
    shared Language|Finished lex( {Character*} input ) {
        variable {Character*} remainingInput = input;
        for ( rule in rules ) {
            value result = rule.recognize( remainingInput );
            if ( exists result ) {
                remainingInput = result[1];
                return result.first;
            }
        }
        return finished;
    }
}

// FRAMEWORK MIXINS

shared interface Token1
    satisfies Token
{
    shared actual String text => "1";
}

shared interface Token2
    satisfies Token
{
    shared actual String text => "2";
}

shared class OneCharLexerRule<Language,T>( T token )
    satisfies LexerRule<Language>
    given Language satisfies Token
    given T satisfies Language
{
    Character character;
    assert ( exists ch = token.text[0] );
    character = ch;
    
    shared actual [Language,{Character*}]? recognize( {Character*} input ) {
        if ( exists ch = input.first ) {
            if ( ch == character ) {
                return [this.token,input.rest];
            }
        }
        return null;
    }
}
    
    
// CONCRETE LANGUAGE
    
shared abstract class MyLanguage()
    of MyToken1 | MyToken2
    satisfies Token
{
}
    
shared class MyToken1()
    extends MyLanguage()
    satisfies Token1
{
}

shared class MyToken2()
    extends MyLanguage()
    satisfies Token2
{
}

shared class Token1LexerRule( )
    extends OneCharLexerRule<MyLanguage,MyToken1>( MyToken1() )
{
}

shared class Token2LexerRule( )
    extends OneCharLexerRule<MyLanguage,MyToken2>( MyToken2() )
{
}


shared object myLexer
    extends Lexxer<MyLanguage>( { Token1LexerRule(), Token2LexerRule() } ) {
    
}
