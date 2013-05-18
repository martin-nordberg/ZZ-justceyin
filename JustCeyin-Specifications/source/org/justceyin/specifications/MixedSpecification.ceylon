
import org.justceyin.expectations.constraints { 
    ConstraintCheckComposite, 
    ConstraintCheckResult
}
import org.justceyin.specifications.requirements { Requirement }

"Specification mixin defined in terms of a both declarative requirements and test functions."
by "Martin E. Nordberg III"
shared interface MixedSpecification 
    satisfies DeclarativeSpecification & ImperativeSpecification
{
    
    "Execute the tests defined in a derived class."
    shared actual default ConstraintCheckResult check() {
        
        variable [ConstraintCheckResult*] testResults = [];

        "Accumulates the results of individual tests into a composite result."
        void outcomes( ConstraintCheckResult* moreResults ) {
            moreResults.collect( (ConstraintCheckResult r) => testResults = testResults.withLeading( r ) );
        }
        
        "Helper function for checking that a requirement is satisfied."
        ConstraintCheckResult checkRequirementEntry( String->Requirement requirement ) =>
            requirement.item.check( requirement.key );

        // start with the declarative requirements
        variable [ConstraintCheckResult*] specResults = 
            requirements.collect( checkRequirementEntry ).reversed;
        
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
        return ConstraintCheckComposite( "TBD: Mixed Title", specResults.reversed );
    }

}
