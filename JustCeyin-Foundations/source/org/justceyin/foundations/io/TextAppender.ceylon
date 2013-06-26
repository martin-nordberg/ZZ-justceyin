
"Service provider interface for output writers."
shared interface TextAppender
{
    "Write a string known to contain no line breaks to the output."
    shared formal void append(
        "Output string known to contain no line breaks."
        String output
    );
    
    "Writes a line break to the output."
    shared formal void appendNewLine();

}

