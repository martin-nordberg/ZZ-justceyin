

shared interface IndentationStrategy {
    
    "Returns the current level of indentation (number of spaces)."
    shared formal Integer currentIndentationLevel;
    
    "Indents to the given indentation level or by default to the next level defined by this strategy." 
    shared formal void indent( Integer? newIndent = null );
    
    "Unindents to the previous level."
    shared formal void unindent();
    
}
