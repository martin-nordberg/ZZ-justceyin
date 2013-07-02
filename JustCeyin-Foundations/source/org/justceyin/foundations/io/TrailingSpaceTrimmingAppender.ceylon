
"Decorator removes trailing space from appender output."
shared class TrailingSpaceTrimmingAppender( TextAppender appender )
    satisfies TextAppender {
    
    "Write a string known to contain no line breaks to the output."
    shared default actual void append(
        "Output string known to contain no line breaks."
        String output
    ) {
        this.appender.append( output.trimTrailingCharacters( " \t" ) );
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
    
}
