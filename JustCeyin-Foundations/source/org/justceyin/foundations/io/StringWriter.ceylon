
"Writer with output to a string builder."
shared class StringWriter()
    extends AbstractTextWriter()
{
    "The string builder for the output of this writer."    
    StringBuilder stringBuilder = StringBuilder();
    
    "Implementation for appending to a string builder."
    shared actual class TextWriterImpl()
        extends super.TextWriterImpl()
        satisfies TextWriter & Closeable
    {
        
        "Write a string known to contain no line breaks to the output."
        shared actual void append(
            "The text to be written."
            String output
        ) {
            outer.stringBuilder.append( output );
        }
        
        "Writes a line break to the output."
        shared actual void appendNewLine() {
            outer.stringBuilder.appendNewline();
        }

        "Extracts the result of the string output"
        shared actual String string {
            return outer.stringBuilder.string;
        }
    }
   
    "Extracts the result of the string output"
    shared actual String string {
        return stringBuilder.string;
    }
}

