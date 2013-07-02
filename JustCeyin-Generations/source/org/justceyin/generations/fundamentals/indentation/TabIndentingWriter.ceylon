
import org.justceyin.foundations.io { 
    TextAppender
}

"Writer adapter that translates leading tabs to indentations."
shared class TabIndentingWriter( 
    TextAppender appender, 
    IndentationStrategy indentationStrategy = FixedIndentationStrategy()
)
    extends IndentingWriter( appender, indentationStrategy )
{
    
    "Writes a string to the output, treating tabs as indents."
    shared actual void append( String output ) {
        if ( !output.empty ) {
            variable String detabbedOutput = output.trimLeadingCharacters( "\t" );
            variable Integer nTabs = output.size - detabbedOutput.size;

            // indent once for each tab            
            for ( i in 1:nTabs ) {
                this.indent();
            }

            // write the rest of the line
            super.append( detabbedOutput );

            // unindent symmetrically
            for ( i in 1:nTabs ) {
                this.unindent();
            }
        }
    }

}
