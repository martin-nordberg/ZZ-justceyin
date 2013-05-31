
import ceylon.file { 
    Path 
}
import org.justceyin.foundations.logging {
    FileLogWriter
}

"Low level interface to an output writer."
shared interface LogWriter
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

"Create a log writer with output to a file."
shared LogWriter createFileLogWriter( 
    "The path to the log file to be written"
    Path logFilePath, 
    "Whether to append to an existing file"
    Boolean append = true, 
    "The encoding for the output"
    String encoding = "UTF-8"
) {
    return FileLogWriter( logFilePath, append, encoding );
}
