"
 Package containing expectations - classes that initiate constraint checking within behavior-driven 
 development specifications or within ordinary code for design-by-contract.
 
 This package is meant to be used in two ways:
 
 **1. Design by Contract - Fluent Assertions**
 
 Use the `constrain` and `guarantee` functions to enforce preconditions or postconditions at run time
 in an ordinary function or in traditional testing code. Fluent assertions defined this way will
 immediately throw a usual AssertionException if the expectation is not met. 

 \`\`\`    
     /** Example of using preconditions and postconditions. */
     String elideLongText( Integer maxLength )( String text ) {
     
         // precondition
         constrain( maxLength ).named( \"maxLength\" ).toBe( anInteger.greaterThan(5) );
     
         String result;
         if ( text.size > maxLength ) {
             value halfLength = maxLength/2 - 1;
             result = text.segment( 0, maxLength-halfLength-3 ) + \"...\" + text.segment(text.size-halfLength,halfLength);
         }
         else {
             result = text;
         }
     
         // postcondition
         guarantee( result ).named( \"result\" ).toBe( aString.withMaximumLength( maxLength ) );
     
         return result;
     }
 \`\`\`
     
 **2. Behavior-Driven Development - Fluent Outcomes**
 
 Use the `expect` function to set up a constraint to be checked in an imperative style 
 `org.justceyin.specifications.Specification`. Expectations used this way can be accumulated
 by a specification runner and then output by a specification reporter.
 
 \`\`\`
     shared class ElideLongTextSpecification()
        satisfies ImperativeSpecification { 
        
        shared actual String title = \"ElideLongTextSpecification\"; 
        String fifteenChars = \"123456789012345\";
        
        void testElision( void outcomes( ConstraintCheckResult* results ) ) {
            value tenChars = elideLongText( 10 )( fifteenChars );
            outcomes(
                // expected outcome of the test
                expect( tenChars ).named( \"fifteen characters elided to ten\").toBe( aString.withValue( \"123...2345\" ) ) 
            );
        }
        
        void testNonElision( void outcomes( ConstraintCheckResult* results ) ) {
            value alsoFifteenChars = elideLongText( 15 )( fifteenChars );
            outcomes( 
                // expected outcome of the test
                expect( alsoFifteenChars ).named( \"fifteen characters elided to fifteen\").toBe( aString.withValue( \"123456789012345\" ) ) 
            );
        }
        
        shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
            testElision,
            testNonElision
        };
     }
 \`\`\`

 NOTE: The classes in this package are all intermediate results produced by constrain, guarantee, or expect. 
 None are meant to be used directly.
"
by "Martin E. Nordberg III"
shared package org.justceyin.expectations;
