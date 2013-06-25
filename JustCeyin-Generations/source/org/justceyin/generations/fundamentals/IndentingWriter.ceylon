
import org.justceyin.foundations.io { 
    LineWriter
}

String spaces = "                                                                                ";

shared class IndentingWriter( 
    LineWriter writer, 
    IndentationStrategy indentationStrategy 
) {
    
    variable StringBuilder currentLine = StringBuilder();
    
    shared void indent() {
        this.indentationStrategy.indent();
    }
    
    shared void indentToCurrentColumn() {
        this.indentationStrategy.indent( currentLine.size );
    }
    
    shared void unindent() {
        this.indentationStrategy.unindent();
    }
    
    "Writes a string to the output, taking into account the indent level."
    shared void write( String output ) {
        if ( !output.empty ) {
            if ( currentLine.size == 0 ) {
                currentLine.append( spaces.initial( this.indentationStrategy.currentIndentationLevel ) );
            }
            
            // TBD: break output into lines if needed
            
            currentLine.append( output );
        }
    }
    
    "Writes a string and line terminator to the output."
    shared void writeLine( String output ) {
        this.write( output );
        
        writer.writeLine( currentLine.string );
        
        currentLine = StringBuilder();
    }

}
