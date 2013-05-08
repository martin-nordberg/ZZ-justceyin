
import org.justceyin.expectations {
	expect
}

import org.justceyin.expectations.constraints.providers { 
    aString
}
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all integer constraints."
shared void runStringConstraintTests( TestResultLog log ) {
    String emptyStr = "";
    String shortStr = "A";
    String longStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    
    log.ensureSuccess( expect( emptyStr ).named( "emptyStr" ).toBe( aString.withValue( "" ) ) );
    log.ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.longerThan( 0 ) ) );
    log.ensureSuccess( expect( emptyStr ).named( "emptyStr" ).toBe( aString.shorterThan( 1 ) ) );
    log.ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatIsNotEmptyWithMaximumLength( 1 ) ) );
    log.ensureSuccess( expect( emptyStr ).named( "emptyStr" ).toBe( aString.withMaximumLength( 1 ) ) );
    log.ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.withMinimumLength( 1 ) ) );
    log.ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatContains( "A" ) ) );
    log.ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatContainsAnyElementOf( {"A","B"} ) ) );
    log.ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatContainsEveryElementOf( {"A","B"} ) ) );
    log.ensureSuccess( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatIsEmpty ) );
    log.ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.thatIsNotEmpty ) );
    log.ensureFailure( expect( emptyStr ).named( "emptyStr" ).toBe( aString.withSize( 1 ) ) );
    
    log.ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.withValue( "A" ) ) );
    log.ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.longerThan( 0 ) ) );
    log.ensureFailure( expect( shortStr ).named( "shortStr" ).toBe( aString.longerThan( 1 ) ) );
    log.ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.shorterThan( 2 ) ) );
    log.ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.withMaximumLength( 1 ) ) );
    log.ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.thatIsNotEmptyWithMaximumLength( 1 ) ) );
    log.ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.withMinimumLength( 1 ) ) );
    log.ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.thatContains( "A" ) ) );
    log.ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.thatContainsAnyElementOf( {"A","AB"} ) ) );
    log.ensureFailure( expect( shortStr ).named( "shortStr" ).toBe( aString.thatContainsEveryElementOf( 'A'..'Z' ) ) );
    log.ensureFailure( expect( shortStr ).named( "shortStr" ).toBe( aString.thatIsEmpty ) );
    log.ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.thatIsNotEmpty ) );
    log.ensureSuccess( expect( shortStr ).named( "shortStr" ).toBe( aString.withSize(1) ) );
    
    log.ensureFailure( expect( longStr ).named( "longStr" ).toBe( aString.withValue( "xyz" ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.longerThan( 0 ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.longerThan( 1 ) ) );
    log.ensureFailure( expect( longStr ).named( "longStr" ).toBe( aString.shorterThan( 2 ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.shorterThan( 53 ) ) );
    log.ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.withMaximumLength( 52 ) ) );
    log.ensureSuccess( expect( shortStr ).named( "emptyStr" ).toBe( aString.thatIsNotEmptyWithMaximumLength( 52 ) ) );
    log.ensureFailure( expect( shortStr ).named( "emptyStr" ).toBe( aString.withMinimumLength( 53 ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContains( "A" ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContains( 'A' ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContainsAnyElementOf( {"A","AB"} ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContainsEveryElementOf( {"A","AB"} ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContainsEveryElementOf( {'A','B','C'} ) ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatContainsEveryElementOf( 'A'..'C' ) ) );
    log.ensureFailure( expect( longStr ).named( "longStr" ).toBe( aString.thatIsEmpty ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.thatIsNotEmpty ) );
    log.ensureSuccess( expect( longStr ).named( "longStr" ).toBe( aString.withSize(52) ) );

}
