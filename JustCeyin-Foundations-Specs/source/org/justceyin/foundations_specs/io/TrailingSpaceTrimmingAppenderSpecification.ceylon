
import org.justceyin.foundations.io {
    StringAppender,
    TextWriter,
    TextWriterAppender,
    TrailingSpaceTrimmingAppender
}
import org.justceyin.specifications {
    ImperativeSpecification
}
import org.justceyin.expectations.constraints { 
    ConstraintCheckResult 
}
import org.justceyin.expectations { 
    expect 
}
import org.justceyin.expectations.constraints.providers { 
    aString 
}


"Specification exercises a TrailingSpaceTrimmingAppender."
by "Martin E. Nordberg III"
shared class TrailingSpaceTrimmingAppenderSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "Trailing Space Trimming Appender Specification";
    
    "Very simple output has the right line terminations and no trailing spaces."
    void testSimpleOutput( void outcomes( ConstraintCheckResult* results ) ) {
        StringAppender appender = StringAppender();
        TextWriter writer = TextWriterAppender( TrailingSpaceTrimmingAppender( appender ) );
        try {
            writer.open();
            writer.write( "ABC  \t " );
            writer.writeLine();
            writer.close( null );
            value result = appender.string;
            
            outcomes( expect( result.string ).named( "trailing space trimming output" ).toBe( aString.withValue( "ABC\n" ) ) );
        }
        finally {
            writer.close( null );
        }
    }
    
    "Multi-line strings are split into multiple output lines with all trailing spaces removed."
    void testMultilineOutput( void outcomes( ConstraintCheckResult* results ) ) {
        StringAppender appender = StringAppender();
        TextWriter writer = TextWriterAppender( TrailingSpaceTrimmingAppender( appender ) );
        try {
            writer.open();
            writer.writeLine( "ABC  \r\nDEF\t \r\nGHI " );
            writer.close( null );
            value result = appender.string;
            
            outcomes( expect( result.string ).named( "trailing space trimming output" ).toBe( aString.withValue( "ABC\nDEF\nGHI\n" ) ) );
        }
        finally {
            writer.close( null );
        }
    }
    
    "Blank lines with spaces are truncated properly."
    void testBlankLineOutput( void outcomes( ConstraintCheckResult* results ) ) {
        StringAppender appender = StringAppender();
        TextWriter writer = TextWriterAppender( TrailingSpaceTrimmingAppender( appender ) );
        try {
            writer.open();
            writer.writeLine( "ABC\r\n  \r\nDEF\r\n" );
            writer.close( null );
            value result = appender.string;
            
            outcomes( expect( result.string ).named( "trailing space trimming output" ).toBe( aString.withValue( "ABC\n\nDEF\n\n" ) ) );
        }
        finally {
            writer.close( null );
        }
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testSimpleOutput,
        testMultilineOutput,
        testBlankLineOutput
    };

}
