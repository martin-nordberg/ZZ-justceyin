
import ceylon.file { 
    Path, 
    CeylonFileWriter = Writer
}
import org.justceyin.foundations.files { 
    createFileWriter 
}

"Writer with output to a file."
shared class FileAppender( 
    "The path to the log file to be written"
    Path logFilePath, 
    "Whether to append to an existing file"
    Boolean appendExisting = false, 
    "The encoding for the output"
    String encoding = "UTF-8"
)
    satisfies TextAppender 
{
    "The writer for the output of this log."    
    CeylonFileWriter fileWriter = createFileWriter( logFilePath, appendExisting, encoding );
    
    "Write a string known to contain no line breaks to the output."
    shared actual void append(
        "The text to be written."
        String output
    ) {
        this.fileWriter.write( output );
    }
    
    "Writes a line break to the output."
    shared actual void appendNewLine() {
        this.fileWriter.writeLine( "" );
    }

    "Closes the log file."
    shared actual void close( Exception? exception) {
        this.fileWriter.close( exception );
    }
    
    "Opens the log file."
    shared actual void open() {
        this.fileWriter.open();
    }
    
}

