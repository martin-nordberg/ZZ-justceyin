
import org.justceyin.foundations.io { 
    TextAppender, 
    TextWriterAppender
}

String spaces = "                                                                                ";

"Writer adapter that adds indenting to an adapted inner text appender."
shared class IndentingWriter( 
    TextAppender appender, 
    IndentationStrategy indentationStrategy = FixedIndentationStrategy()
)
    extends TextWriterAppender( appender )
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
    shared default actual void append( String output ) {
        if ( !output.empty ) {
            if ( currentColumn == 0 ) {
                super.append( spaces.initial( this.indentationStrategy.currentIndentationLevel ) );
            }
            super.append( output );
        }
    }
    
    "Writes a line terminator to the output."
    shared actual void appendNewLine() {
        super.appendNewLine();
        
        currentColumn = 0;
    }

}
