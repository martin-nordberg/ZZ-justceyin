
import org.justceyin.expectations.constraints {
    ConstraintCheckResult, 
    ConstraintCheckComposite
}

"Specification mixin defined in terms of a number of test functions to be executed."
by "Martin E. Nordberg III"
shared interface ImperativeSpecification 
    satisfies Specification
{
    
    "The title of this specification."
    shared formal String title;
        // TBD: Derive the title from the doc annotation (M6) of a derived class
    
    // TBD: use results in compiler bug
//    "Type alias for use in derived class tests."
//    shared alias Outcomes => Anything ( ConstraintCheckResult* );
    
    "The tests (in a derived class to be executed). Each test passes back one or 
     more constraint checking results to an outcomes callback that accumulates them into
     a composite constraint checking result."
    shared formal {Anything(Anything ( ConstraintCheckResult* ))+} tests;
    
    "Execute the tests defined in a derived class."
    shared actual default ConstraintCheckResult check() {
        
        variable [ConstraintCheckResult*] testResults = [];

        "Accumulates the results of individual tests into a composite result."
        void outcomes( ConstraintCheckResult* moreResults ) {
            moreResults.collect( (ConstraintCheckResult r) => testResults = testResults.withLeading( r ) );
        }
        
        variable [ConstraintCheckResult*] specResults = [];
        
        // iterate over the tests
        for ( test in tests ) {
            // compile the results of one test
            testResults = [];
            test( outcomes );
            value testResult = ConstraintCheckComposite( "Test Result (TBD)", testResults.reversed );

            // add each test result to the spec result
            specResults = specResults.withLeading( testResult );
        }
        
        // bundle the overall results
        return ConstraintCheckComposite( this.title, specResults.reversed );
    }

}
