
"Interface to an abstract facility for recognizing tokens of a given type."
shared interface TokenRecognizer<Language>
{
    "The displayable name of the recognized token for lexer messages."
    shared formal String name;

    "Recognizes a token if possible."
    shared formal Boolean recognize(
        "Callback function receives tokens recognized by the lexer."
        Anything(Token<Language>) yield,
        "The next input character to be recognized."
        Character nextCharacter
    );

    "The characters that could potentially start tokens recognized by this recognizer."
    shared formal [Character] startingCharacters;

}
