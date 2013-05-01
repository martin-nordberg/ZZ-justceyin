
import org.justceyin.expectations {
	expect
}

import org.justceyin.expectations.constraints.providers { 
    aString
}
import org.justceyin.tests.expectations.constraints { ensureFailure, ensureSuccess }

"Exercises all integer constraints."
shared void runStringConstraintTests() {
    String emptyStr = "";
    String shortStr = "A";
    String longStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    
    ensureSuccess( expect( emptyStr ).named( "emptyStr" ).toBe( aString.withValue( "" ) ) );
    ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.longerThan( 0 ) ) );
    ensureSuccess( expect( emptyStr ).named( "emptyStr" ).toBe( aString.shorterThan( 1 ) ) );
    ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatIsNotEmptyWithMaximumLength( 1 ) ) );
    ensureSuccess( expect( emptyStr ).named( "emptyStr" ).toBe( aString.withMaximumLength( 1 ) ) );
    ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.withMinimumLength( 1 ) ) );
    ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatContains( "A" ) ) );
    ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatContainsAnyElementOf( {"A","B"} ) ) );
    ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatContainsEveryElementOf( {"A","B"} ) ) );
    ensureSuccess( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatIsEmpty ) );
    ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatIsNotEmpty ) );
    ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.withSize( 1 ) ) );
    
    ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.withValue( "A" ) ) );
    ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.longerThan( 0 ) ) );
    ensureFailure( expect( shortStr ).named( "shortStr" ).toBe( aString.longerThan( 1 ) ) );
    ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.shorterThan( 2 ) ) );
    ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.withMaximumLength( 1 ) ) );
    ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.thatIsNotEmptyWithMaximumLength( 1 ) ) );
    ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.withMinimumLength( 1 ) ) );
    ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.thatContains( "A" ) ) );
    ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.thatContainsAnyElementOf( {"A","AB"} ) ) );
    ensureFailure( expect( shortStr ).named( "shortStr" ).toBe( aString.thatContainsEveryElementOf( 'A'..'Z' ) ) );
    ensureFailure( expect( shortStr ).named( "shortStr" ).toBe( aString.thatIsEmpty ) );
    ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.thatIsNotEmpty ) );
    ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.withSize(1) ) );
    
    ensureFailure( expect( longStr ).named( "longStr" ).toBe( aString.withValue( "xyz" ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.longerThan( 0 ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.longerThan( 1 ) ) );
    ensureFailure( expect( longStr ).named( "longStr" ).toBe( aString.shorterThan( 2 ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.shorterThan( 53 ) ) );
    ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.withMaximumLength( 52 ) ) );
    ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.thatIsNotEmptyWithMaximumLength( 52 ) ) );
    ensureFailure( expect( shortStr ).named( "emptyStr" ).toBe( aString.withMinimumLength( 53 ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContains( "A" ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContains( 'A' ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContainsAnyElementOf( {"A","AB"} ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContainsEveryElementOf( {"A","AB"} ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContainsEveryElementOf( {'A','B','C'} ) ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContainsEveryElementOf( 'A'..'C' ) ) );
    ensureFailure( expect( longStr ).named( "longStr" ).toBe( aString.thatIsEmpty ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatIsNotEmpty ) );
    ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.withSize(52) ) );

}
