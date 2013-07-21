
import org.justceyin.tests.expectations { 
    TestResultLog 
}

"Exercises all constraints."
shared void runConstraintProviderTests( TestResultLog log ) {

    log.writeLine( "" );
    log.writeLine( "Constraint Tests:" );
    log.writeLine( "-----------------" );

    log.writeLine( " Boolean Constraints:" );
    runBooleanConstraintTests( log );

    log.writeLine( " Character Constraints:" );
    runCharacterConstraintTests( log );

    log.writeLine( " Date Constraints:" );
    runDateConstraintTests( log );

    log.writeLine( " Date Time Constraints:" );
    runDateTimeConstraintTests( log );

    log.writeLine( " Integer Constraints:" );
    runIntegerConstraintTests( log );

    log.writeLine( " Float Constraints:" );
    runFloatConstraintTests( log );

    log.writeLine( " String Constraints:" );
    runStringConstraintTests( log );

}

