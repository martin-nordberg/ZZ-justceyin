

"Concrete indentation strategy that uses less space as the indentation level increases."
shared class DiminishingIndentationStrategy()
    satisfies IndentationStrategy
{
    
    "Stack of indentation levels."
    variable [Integer*] indentationLevels = [];
    
    "Returns the current level of indentation (number of spaces)."
    shared actual Integer currentIndentationLevel {
        if ( exists result = this.indentationLevels.first ) {
            return result;
        }
        return 0;
    }
    
    "Indents to the given indentation level or by default to the next level defined by this strategy." 
    shared actual void indent( Integer? newIndent ) {
        if ( exists newIndent ) {
            this.indentationLevels = [ newIndent, *this.indentationLevels ];
        }
        else {
            value curr = this.currentIndentationLevel;
            if ( curr < 16 ) {
                this.indentationLevels = [ ((curr+4)/4)*4, *this.indentationLevels ];
            }
            else {
                this.indentationLevels = [ ((curr+2)/2)*2, *this.indentationLevels ];
            }
        }
    }
    
    "Unindents to the previous level."
    shared actual void unindent() {
        this.indentationLevels = this.indentationLevels.rest;
    }
    
}
