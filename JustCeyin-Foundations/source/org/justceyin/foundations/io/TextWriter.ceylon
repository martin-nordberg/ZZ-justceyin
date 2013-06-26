

"Interface to a line-oriented text output writer."
shared interface TextWriter
    satisfies Closeable
{

    "Writes a string to the output."
    shared formal void write(
        "The text to be written."
        String output
    );

    "Writes a string and line terminator to the output."
    shared formal void writeLine(
        "The text to be written on a full line."
        String? output = null
    );    

}
