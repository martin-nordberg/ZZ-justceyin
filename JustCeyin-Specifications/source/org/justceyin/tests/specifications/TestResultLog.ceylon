
import ceylon.language {
    printStdOut = print
}

"Utility class for writing out test results."
shared class TestResultLog( )
    satisfies Closeable {
    
    "Closes the log."
    shared actual void close( Exception? e ) {
        
    }
    
    "Opens the log."
    shared actual void open() {
        
    }

    "Prints a line of output."
    shared void print( String output ) {
        printStdOut( output );
    }

}