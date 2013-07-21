
"Base interface to a token with source name and position as output by a lexer."
shared interface SourcedToken<Language>
    satisfies Token<Language>
{
    
    "The column of the source where this token originated."
    shared formal Integer sourceColumn;
    
    "The line of the source where this token originated."
    shared formal Integer sourceLine;
    
    "The name of the file or other source of this token."
    shared formal String sourceName;
    
}
