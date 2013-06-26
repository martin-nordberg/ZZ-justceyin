
"Writer with output to a string builder."
shared class StringWriter()
    extends AbstractTextWriter()
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

    "Extracts the result of the string output"
    shared actual String string {
        return this.stringBuilder.string;
    }
   
}

