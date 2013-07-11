
"Base interface to token output by a lexer."
shared interface Token<Language> {
    
    "Trivial test exercises the marker type Language."
    shared Boolean isForLanguage( Language language ) {
        return true;
    }
    
    "The text of the token (exactly as recognized by the lexer)."
    shared formal String text;
    
}
