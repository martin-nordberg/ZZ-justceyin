
import ceylon.file { 
    File, 
    Nil, 
    Path, 
    Writer 
}

"Utility class for writing out test results."
shared class TestResultLog( Path outputPath )
    satisfies Closeable {

    "The writer for the output of this log."    
    Writer writer;
    if ( is Nil resource = outputPath.resource ) {
        writer = resource.createFile().writer( "UTF-8" );
    }
    else {
      assert ( is File file = outputPath.resource );
      writer = file.writer( "UTF-8" );
    }
    
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