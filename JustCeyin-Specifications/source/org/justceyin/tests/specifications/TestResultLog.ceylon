
import ceylon.file { 
    Path, 
    Writer 
}
import org.justceyin.foundations.files {
    createFileWriter
}

"Utility class for writing out test results."
shared class TestResultLog( Path outputPath )
    satisfies Closeable {

    "The writer for the output of this log."    
    Writer writer = createFileWriter( outputPath );
    
    "Closes the log."
    shared actual void close( Exception? e ) {
        this.writer.close( e );
    }
    
    "Opens the log."
    shared actual void open() {
        this.writer.open();
    }

    "Prints a line of output."
    shared void print( String output ) {
        writer.writeLine( output );
    }

}