

"Concrete indentation strategy that uses less space as the indentation level increases."
shared class DiminishingIndentationStrategy(
    Integer initialIndentationIncrement = 4,
    Integer reducedIndentationIncrement = 2,
    Integer columnForReducedIndentation = 16,
    Integer maxIndentationLevel = 60
)
    extends AbstractIndentationStrategy( maxIndentationLevel )
{
    
    "Determines the next indentation level to use."
    shared actual Integer nextIndentationLevel( Integer currentIndentationLevel ) {
        Integer increment;
        if ( currentIndentationLevel < this.columnForReducedIndentation ) {
            increment = this.initialIndentationIncrement;
        }
        else {
            increment = this.reducedIndentationIncrement;
        }
        return ((currentIndentationLevel+increment)/increment)*increment;
    }
    
}
