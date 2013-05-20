Just Ceyin - Experimental Frameworks for Ceylon
===============================================

Martin E. Nordberg III
May 20, 2013

Just Ceyin - Expectations
-------------------------

This module contains classes that initiate constraint checking within behavior-driven 
development specifications or within ordinary code for design-by-contract.
 
This module is meant to be used in two ways:
 
**1. Design by Contract - Fluent Assertions**
 
Use the `constrain` and `guarantee` functions to enforce preconditions or postconditions at run time
in an ordinary function or in traditional testing code. Fluent assertions defined this way will
immediately throw a usual AssertionException if the expectation is not met. 

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
    
**2. Behavior-Driven Development - Fluent Outcomes**

Use the `expect` function to set up a constraint to be checked in an imperative style 
`org.justceyin.specifications.Specification`. Expectations used this way can be accumulated
by a specification runner and then output by a specification reporter.
 
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

NOTE: The classes in this module are all intermediate results produced by constrain, guarantee, or expect. 
None are meant to be used directly.

Just Ceyin - Specifications
---------------------------

This module contains classes for defining behavior-driven development (BDD) style specifications.
 
Two styles of specification are supported by this package: imperative and declarative.
 
**Imperative Specifications**

* Inherit from `ImperativeSpecification`.
* Implement a number of test methods, each taking a callable outcomes parameter.
* Each test method should call outcomes with one or more expectations, generally started by `expect(..)...`
* Define an actual `tests` member that collects the test methods into a sequence. (Subject to change when Ceylon implements annotations.)
 
    "An example specification illustrating how to go about creating an imperative specification defined in
    terms of test methods, where each requirement uses the fluent interface of org.justceyin.expectations
    to declare expected outcomes for the results of the test."
    shared class IntegerStackImperativeSpecification()
        satisfies ImperativeSpecification
    {
        
        shared actual String title = "IntegerStackImperativeSpecification"; 
        
        // constraints
        value anIntegerStack = StackConstraints<Integer>();
        
        "A stack starts out empty."
        void testNewStack( void outcomes( ConstraintCheckResult* results ) ) {
            value stack = Stack<Integer>();
            outcomes( expect( stack ).named( "stack" ).toBe( anIntegerStack.thatIsEmpty ),
                      expect( stack.topIfPresent ).named( "top of stack" ).toNotExist() );
        }
        
        "A pushed value becomes the new top of the stack."
        void testPush( void outcomes( ConstraintCheckResult* results ) ) {
            value stack = Stack<Integer>().push(1);
            outcomes( expect( stack.top ).named( "top of stack" ).toBe( anInteger.withValue(1) ) );
        }
        
        "Pushing then popping leaves the original stack."
        void testPushThenPop( void outcomes( ConstraintCheckResult* results ) ) {
            value stack = Stack<Integer>().push(1).pop();
            outcomes( expect( stack ).named( "stack" ).toBe( anIntegerStack.thatIsEmpty ),
                      expect( stack.topIfPresent ).named( "top of stack" ).toNotExist() );
        }
        
        "Pushing then popping leaves the original stack (intermediate steps checked)."
        void testPushThenPopSequence( void outcomes( ConstraintCheckResult* results ) ) {
            value stack0 = Stack<Integer>();
            
            outcomes( expect( stack0 ).named( "stack" ).toBe( anIntegerStack.thatIsEmpty ),
                      expect( stack0.topIfPresent ).named( "top of stack" ).toNotExist() );

            value stack1 = stack0.push( 1 );
            
            outcomes( expect( stack1.top ).named( "top of stack" ).toBe( anInteger.withValue(1) ) );
            
            value stack2 = stack1.pop();
            
            outcomes( expect( stack2 ).named( "stack" ).toBe( anIntegerStack.thatIsEmpty ),
                      expect( stack2.topIfPresent ).named( "top of stack" ).toNotExist() );
        }
        
        "The tests within this specification. (TBD: to be replaced by annotations (M6)."
        shared actual {Anything(Anything(ConstraintCheckResult*))+} tests = {
            testNewStack,
            testPush,
            testPushThenPop,
            testPushThenPopSequence
        };
        
    }
 
**Declarative Specifications**

* Inherit from `DeclarativeSpecification`.
* Implement the `requirements` attribute which maps from requirement summary strings to `Requirement` instances. (Subject to change when Ceylon implements annotations.)

    "An example specification illustrating how to go about creating a declarative specification defined in
    terms of named requirements, where each requirement uses the fluent interface of org.justceyin.expectations
    to declare an expected result for one or more inputs going through zero or more setup/transform steps."
    shared class IntegerStackDeclarativeSpecification()
        satisfies DeclarativeSpecification
    { 
        
        shared actual String title = "IntegerStackDeclarativeSpecification"; 
        
        // starting values
        Stack<Integer> anEmptyStack() => Stack<Integer>();
        Stack<Integer> aStackOfOne() => Stack<Integer>().push(1);
        Stack<Integer> aStackOfTwoOne() => Stack<Integer>().push(1).push(2);
        
        // constraints
        value anIntegerStack = StackConstraints<Integer>();
        
        // requirements
        shared actual {<String->Requirement>+} requirements = {
            
            "A stack starts out empty."->
            StartingFrom( anEmptyStack ).expect( anIntegerStack.thatIsEmpty ),
            
            "Pushing then popping leaves the original stack."->
            StartingFrom( anEmptyStack ).after( pushOntoStack(1) ).followedBy( popStack<Integer> ).expect( anIntegerStack.thatIsEmpty ),
            
            "A stack with one item is empty after popping that item."->
            StartingFrom( aStackOfOne ).after( popStack<Integer> ).expect( anIntegerStack.thatIsEmpty ),
            
            "A stack with two items is empty after popping both items."->
            StartingFrom( aStackOfTwoOne ).after( popStack<Integer> ).followedBy( popStack<Integer> ).expect( anIntegerStack.thatIsEmpty ),
            
            "The top of a stack with one value yields that value."->
            StartingFrom( aStackOfOne ).after( topOfStack<Integer> ).expect( anInteger.withValue(1) ),
            
            "The top of a stack with two values yields the last pushed value."->
            StartingFrom( aStackOfTwoOne ).after( topOfStack<Integer> ).expect( anInteger.withValue(2) ),
            
            "A pushed value becomes the new top of the stack."->
            StartingFromAnyOf( {anEmptyStack,aStackOfOne,aStackOfTwoOne} ).after( pushOntoStack(100) ).expect( anIntegerStack.withTop(100) ),
            
            "A pushed value becomes the new top of the stack."->
            StartingFrom( anEmptyStack ).or( aStackOfOne ).or( aStackOfTwoOne ).after( pushOntoStack(100) ).followedBy( topOfStack<Integer> ).expect( anInteger.withValue(100) ),
            
            "Popping from an empty stack throws an exception."->
            StartingFrom( anEmptyStack ).after( popStack<Integer> ).expectAnException<EmptyStackException>(),

            "Reading the top of an empty stack throws an exception."->
            StartingFrom( anEmptyStack ).after( topOfStack<Integer> ).expectAnException<EmptyStackException>(),
            
            "Reading the 'if present' top of an empty stack yields null."->
            StartingFrom( anEmptyStack ).after( topOfStackIfPresent<Integer> ).expectNonexistentResult()

        };
        
    }

It is also possible to combine the two approaches in a specification derived from `MixedSpecification`.

Navigating the Code
-------------------

* The published Ceylon modules are in JustCeyin-Build/published-modules. These include API documentation that goes beyond this readme file.
* The JustCeyin-Build folder contains an ANT build file for all the JustCeyin modules.
* Self-test code in this first draft release is implemented in ordinary run() methods in separate modules prefixed by tests in the package name.
* Package org.justceyin.specifications.examples includes the above examples plus a bit more.

License
-------

The JustCeyin modules are released under the Apache 2.0 license. See each module.ceylon file for details.


