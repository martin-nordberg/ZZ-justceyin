
"Writer with output to an appender."
shared class TextWriterAppender( TextAppender appender )
    satisfies TextWriter/*API*/ & TextAppender/*SPI*/ & Closeable
{

    "Write a string known to contain no line breaks to the output."
    shared default actual void append(
        "Output string known to contain no line breaks."
        String output
    ) {
        this.appender.append( output );
    }
    
    "Writes a line break to the output."
    shared default actual void appendNewLine() {
        this.appender.appendNewLine();
    }
    
    "Closes the output."
    shared default actual void close( Exception? exception) {
        this.appender.close( exception );
    }
    
    "Opens the output."
    shared default actual void open() {
        this.appender.open();
    }

    "Writes a string to the output."
    shared default actual void write(
        "The text to be written."
        String longOutput
    ) {
        value lineBreaks = "\r\n";
        value outputs = longOutput.split( lineBreaks, false, true );
        
        for ( output in outputs ) {
            if ( exists ch0 = output[0] ) {
                if ( lineBreaks.contains( ch0 ) ) {
                    for ( ch in output ) {
                        if ( ch == '\n' ) {
                            this.appendNewLine();
                        }
                    }
                }
                else {
                    this.append( output );
                }
            }
        }
    }
    
    "Writes a string and line terminator to the output."
    shared default actual void writeLine(
        "The text to be written on a full line."
        String? output 
    ) {
        if ( exists output ) {
            this.write( output );
        }
        this.appendNewLine();
    }
    
}

