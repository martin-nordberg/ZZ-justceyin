

"Abstract indentation strategy that pts the strategy into a single template method."
shared abstract class AbstractIndentationStrategy(
    Integer maxIndentationLevel = 60
)
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
    shared actual void indent( Integer? newIndentationLevel ) {
        variable Integer newIndent;
        if ( exists newIndentationLevel ) {
            newIndent = newIndentationLevel;
        }
        else {
            newIndent = this.nextIndentationLevel( this.currentIndentationLevel );
        }
           
        if ( newIndent > this.maxIndentationLevel ) {
            newIndent = this.maxIndentationLevel;
        }
        
        this.indentationLevels = [ newIndent, *this.indentationLevels ];
    }
    
    "Determines the next indentation level to use."
    shared formal Integer nextIndentationLevel( Integer currentIndentationLevel );
    
    "Unindents to the previous level."
    shared actual void unindent() {
        this.indentationLevels = this.indentationLevels.rest;
    }
    
}
