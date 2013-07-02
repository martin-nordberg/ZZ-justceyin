
"Writer with output to a string builder."
shared class StringAppender()
    satisfies TextAppender
{
    "The string builder for the output of this writer."    
    StringBuilder stringBuilder = StringBuilder();
    
    "Write a string known to contain no line breaks to the output."
    shared actual void append(
        "The text to be written."
        String output
    ) {
        this.stringBuilder.append( output );
    }
    
    "Writes a line break to the output."
    shared actual void appendNewLine() {
        this.stringBuilder.appendNewline();
    }

    "Closes this appender."
    shared actual void close( Exception? exception ) {
    }

    "Extracts the result of the string output"
    shared actual String string {
        return this.stringBuilder.string;
    }
    
    "Opens this appender."
    shared actual void open() {
    }
   
}
