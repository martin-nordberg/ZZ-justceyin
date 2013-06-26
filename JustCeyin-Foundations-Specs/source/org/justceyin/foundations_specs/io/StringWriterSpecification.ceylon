
import org.justceyin.foundations.io {
    StringWriter,
    TextWriter
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
    
    "A random UUID converts to a string with the expected format."
    void testSimpleOutput( void outcomes( ConstraintCheckResult* results ) ) {
        TextWriter writer = StringWriter();
        try {
            writer.open();
            writer.write( "ABC" );
            writer.writeLine();
            writer.close( null );
            value result = writer.string;
            
            outcomes( expect( result.string ).named( "string writer output" ).toBe( aString.withValue( "ABC\n" ) ) );
        }
        finally {
            writer.close( null );
        }
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testSimpleOutput
    };

}
