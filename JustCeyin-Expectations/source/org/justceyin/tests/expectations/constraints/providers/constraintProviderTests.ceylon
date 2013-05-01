
"Exercises all constraints."
shared void runConstraintProviderTests() {

    print( "" );
    print( "Constraint Tests:" );
    print( "-----------------" );

    print( " Boolean Constraints:" );
    runBooleanConstraintTests();

    print( " Date Constraints:" );
    runDateConstraintTests();

    print( " Integer Constraints:" );
    runIntegerConstraintTests();

    print( " Float Constraints:" );
    runFloatConstraintTests();

    print( " String Constraints:" );
    runStringConstraintTests();

}

