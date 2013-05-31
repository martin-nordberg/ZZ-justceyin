
import ceylon.file { 
    Path, 
    Writer
}
import org.justceyin.foundations.files { 
    createFileWriter 
}

"Log writer with output to a file."
class FileLogWriter( 
    "The path to the log file to be written"
    Path logFilePath, 
    "Whether to append to an existing file"
    Boolean append, 
    "The encoding for the output"
    String encoding
)
    satisfies LogWriter 
{
    "The writer for the output of this log."    
    Writer writer = createFileWriter( logFilePath );
    
    "Closes the log file."
    shared actual void close( Exception? exception) {
        writer.close( exception );
    }
    
    "Opens the log file."
    shared actual void open() {
        this.writer.open();
    }
    
    "Writes a string to the log."
    shared actual void write( String output ) {
        this.writer.write( output );
    }
    
    "Writes a string and line terminator to the log."
    shared actual void writeLine( String output ) {
        writer.writeLine( output );
    }
    
    
}