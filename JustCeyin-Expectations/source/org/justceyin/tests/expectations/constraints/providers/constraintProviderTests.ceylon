
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all constraints."
shared void runConstraintProviderTests( TestResultLog log ) {

    log.print( "" );
    log.print( "Constraint Tests:" );
    log.print( "-----------------" );

    log.print( " Boolean Constraints:" );
    runBooleanConstraintTests( log );

    log.print( " Date Constraints:" );
    runDateConstraintTests( log );

    log.print( " Integer Constraints:" );
    runIntegerConstraintTests( log );

    log.print( " Float Constraints:" );
    runFloatConstraintTests( log );

    log.print( " String Constraints:" );
    runStringConstraintTests( log );

}

