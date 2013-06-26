

"Concrete indentation strategy that indents a fixed spacing."
shared class FixedIndentationStrategy(
    Integer indentationIncrement = 4,
    Integer maxIndentationLevel = 60
)
    extends AbstractIndentationStrategy( maxIndentationLevel )
{
    
    "Determines the next indentation level to use."
    shared actual Integer nextIndentationLevel( Integer currentIndentationLevel ) {
        return ((currentIndentationLevel+this.indentationIncrement)/this.indentationIncrement)*this.indentationIncrement;
    }
    
}
