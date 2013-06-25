
import org.justceyin.foundations.fundamentals {
    makeRandomUuid,
    makeUuidFromString
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


"Specification ensures that a UUID is initialized as expected."
by "Martin E. Nordberg III"
shared class UuidSpecification() 
    satisfies ImperativeSpecification {
    
    shared actual String title = "UUID Specification";
    
    "A random UUID converts to a string with the expected format."
    void testRandomUuidInitialization( void outcomes( ConstraintCheckResult* results ) ) {
        value result = makeRandomUuid();
        
        outcomes( expect( result.string ).named( "UUID" ).toBe( aString.withLength( 36 ) ) );
        // TBD: regex for xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    }
    
    "A UUID initialized from a string has the expected value."
    void testStringUuidInitialization( void outcomes( ConstraintCheckResult* results ) ) {
        value uuidString = "e3e6658c-7339-4698-910c-6103e1baad11";
        value result = makeUuidFromString( uuidString );
        
        outcomes( expect( result.string ).named( "UUID" ).toBe( aString.withValue( uuidString ) ) );
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testRandomUuidInitialization,
        testStringUuidInitialization
    };

}
