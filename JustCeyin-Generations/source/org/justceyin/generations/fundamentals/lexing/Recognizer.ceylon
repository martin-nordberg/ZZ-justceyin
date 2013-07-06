
"Interface to an abstract facility for recognizing tokens of a given type."
shared interface Recognizer<Language> 
    given Language satisfies Token 
{
    "The displayable name of the recognized token for lexer messages."
    shared formal String name;

    "Recognizes a token if possible."
    shared formal [Language,{Character*}]? recognize( {Character*} input );

    "The characters that could potentially start tokens recognized by this recognizer."
    shared formal [Character] startingCharacters;

}
