
"Token representing a character in the input not recognized by the lexer."
shared class UnrecognizedCharacterToken<Language>( Character character )
    satisfies Token<Language>
{
    "The text of the token (the unrecognized character)."
    shared actual String text => character.string;
}
