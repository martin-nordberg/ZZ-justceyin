
"Writer with output to a file."
shared abstract class AbstractTextWriter()
    satisfies TextWriter & TextAppender
{

    "Closes the output."
    shared default actual void close( Exception? exception) {
    }
    
    "Opens the output."
    shared default actual void open() {
    }

    "Writes a string to the output."
    shared actual void write(
        "The text to be written."
        String longOutput
    ) {
        value lineBreaks = "\r\n";
        value outputs = longOutput.split( lineBreaks, false, true );
        
        for ( output in outputs ) {
            if ( exists ch = output[0] ) {
                if ( lineBreaks.contains( ch ) ) {
                    this.appendNewLine();
                }
                else {
                    this.append( output );
                }
            }
        }
    }
    
    "Writes a string and line terminator to the output."
    shared actual void writeLine(
        "The text to be written on a full line."
        String? output 
    ) {
        if ( exists output ) {
            this.write( output );
        }
        this.appendNewLine();
    }
    
}

