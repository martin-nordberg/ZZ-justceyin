
"Interface to an abstract facility for recognizing tokens of a given type."
shared interface Recognizer 
{
    "The displayable name of the recognized token for lexer messages."
    shared formal String name;

    "Recognizes a token if possible."
    shared formal [Token,{Character*}]? recognize(
        "The input containing text known to start with one of startingCharacters."
        {Character*} input
    );

    "The characters that could potentially start tokens recognized by this recognizer."
    shared formal [Character] startingCharacters;

}
