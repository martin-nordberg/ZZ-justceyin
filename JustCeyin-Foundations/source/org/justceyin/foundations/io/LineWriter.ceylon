

"Interface to a line-oriented output writer."
shared interface LineWriter
    satisfies Closeable 
{

    "Writes a string to the log."
    shared formal void write(
        "The text to be written."
        String output
    );

    "Writes a string and line terminator to the log."
    shared formal void writeLine(
        "The text to be written on a full line."
        String output 
    );    
    
}
