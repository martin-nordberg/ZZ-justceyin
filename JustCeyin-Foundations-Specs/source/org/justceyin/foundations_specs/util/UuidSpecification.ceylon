
import org.justceyin.foundations.util {
    makeUuid
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
    
    "A normal single-threaded equivalent to the future test computes the right value."
    void testUuidInitialization( void outcomes( ConstraintCheckResult* results ) ) {
        value result = makeUuid();
        
        outcomes( expect( result.string ).named( "UUID" ).toBe( aString.withLength( 36 ) ) );
    }
    
    "The tests within this specification."
    shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
        testUuidInitialization
    };

}