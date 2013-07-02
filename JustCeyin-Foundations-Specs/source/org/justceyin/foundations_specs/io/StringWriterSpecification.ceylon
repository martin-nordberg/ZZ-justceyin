
import org.justceyin.foundations.io {
    StringAppender,
    TextWriter,
    TextWriterAppender
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


"Specification exercises a StringWriter."
by "Martin E. Nordberg III"
shared class StringWriterSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "String Writer Specification";
    
    "Very simple output has the right line terminations."
    void testSimpleOutput( void outcomes( ConstraintCheckResult* results ) ) {
        StringAppender appender = StringAppender();
        TextWriter writer = TextWriterAppender( appender );
        try {
            writer.open();
            writer.write( "ABC" );
            writer.writeLine();
            writer.close( null );
            value result = appender.string;
            
            outcomes( expect( result.string ).named( "string writer output" ).toBe( aString.withValue( "ABC\n" ) ) );
        }
        finally {
            writer.close( null );
        }
    }
    
    "Multi-line strings are split into multiple output lines."
    void testMultilineOutput( void outcomes( ConstraintCheckResult* results ) ) {
        StringAppender appender = StringAppender();
        TextWriter writer = TextWriterAppender( appender );
        try {
            writer.open();
            writer.writeLine( "ABC\r\nDEF\r\nGHI" );
            writer.close( null );
            value result = appender.string;
            
            outcomes( expect( result.string ).named( "string writer output" ).toBe( aString.withValue( "ABC\nDEF\nGHI\n" ) ) );
        }
        finally {
            writer.close( null );
        }
    }
    
    "Blank lines are handled properly."
    void testBlankLineOutput( void outcomes( ConstraintCheckResult* results ) ) {
        StringAppender appender = StringAppender();
        TextWriter writer = TextWriterAppender( appender );
        try {
            writer.open();
            writer.writeLine( "ABC\r\n\r\nDEF\r\n" );
            writer.close( null );
            value result = appender.string;
            
            outcomes( expect( result.string ).named( "string writer output" ).toBe( aString.withValue( "ABC\n\nDEF\n\n" ) ) );
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
