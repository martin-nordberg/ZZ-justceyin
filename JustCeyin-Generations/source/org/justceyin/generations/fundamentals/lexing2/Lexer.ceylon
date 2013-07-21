
"Interface to a lexer yielding tokens from a character stream input."
shared interface Lexer<Language> {
    
    shared formal void lex(
        "Callback function receives tokens recognized by the lexer."
        Anything(Token<Language>) yield,
        "The input to be lexed."
        Iterator<Character> input
    );

}
