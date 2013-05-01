
import org.justceyin.tests.expectations.constraints { 
    runConstraintTests
}
import org.justceyin.tests.expectations.constraints.providers { 
    runConstraintProviderTests 
}

doc "Run the self tests of module `org.justceyin.expectations`."
void run() {
    print( "Cey what you mean ...");
    
    runConstraintProviderTests();
    runConstraintTests();
    
    print( "All tests completed successfully.");
}
