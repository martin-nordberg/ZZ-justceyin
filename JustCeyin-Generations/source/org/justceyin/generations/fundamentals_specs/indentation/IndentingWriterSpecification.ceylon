
import org.justceyin.foundations.io {
    StringWriter
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
import org.justceyin.generations.fundamentals.indentation {
    IndentingWriter
}
    


"Specification exercises a StringWriter."
by "Martin E. Nordberg III"
shared class IndentingWriterSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "Indenting Writer Specification";
    
    "A random UUID converts to a string with the expected format."
    void testSimpleOutput( void outcomes( ConstraintCheckResult* results ) ) {
        StringWriter stringWriter = StringWriter();
        IndentingWriter writer = IndentingWriter( stringWriter );
        try {
            writer.open();
            writer.writeLine( "line 1" );
            writer.indent();
            writer.writeLine( "line 2" );
            writer.indent();
            writer.writeLine( "line 3" );
            writer.unindent();
            writer.writeLine( "line 4" );
            writer.unindent();
            writer.writeLine( "line 5" );
            writer.close( null );
            value result = stringWriter.string;
            
            value expected = "line 1
                                  line 2
                                      line 3
                                  line 4
                              line 5
                             ";
            
            outcomes( expect( result.string ).named( "string writer output" ).toBe( aString.withValue( expected ) ) );
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
