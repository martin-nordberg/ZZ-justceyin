
import org.justceyin.foundations.io { 
    TextAppender, AbstractTextWriter
}

String spaces = "                                                                                ";

"Writer adapter that adds indenting to an adapted inner text appender."
shared class IndentingWriter( 
    TextAppender appender, 
    IndentationStrategy indentationStrategy = FixedIndentationStrategy()
)
    extends AbstractTextWriter()
{
    
    "The current column in the output line."
    variable Integer currentColumn = 0;
    
    "Increases the indent level according to the indentation strategy."
    shared void indent() {
        this.indentationStrategy.indent();
    }
    
    "Increases the indent level to match the current column."
    shared void indentToCurrentColumn() {
        this.indentationStrategy.indent( this.currentColumn );
    }
    
    "Returns the indent level to its previous value."
    shared void unindent() {
        this.indentationStrategy.unindent();
    }
    
    "Writes a string to the output, taking into account the indent level."
    shared actual void append( String output ) {
        if ( !output.empty ) {
            if ( currentColumn == 0 ) {
                this.appender.append( spaces.initial( this.indentationStrategy.currentIndentationLevel ) );
            }
            this.appender.append( output );
        }
    }
    
    "Writes a line terminator to the output."
    shared actual void appendNewLine() {
        appender.appendNewLine();
        
        currentColumn = 0;
    }

}
