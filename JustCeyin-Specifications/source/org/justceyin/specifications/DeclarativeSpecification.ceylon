
import org.justceyin.expectations.constraints {
    ConstraintCheckResult, 
    ConstraintCheckComposite
}
import org.justceyin.specifications.requirements { 
    Requirement 
}

"
 Specification mixin defined in terms of a number of declarative requirements.

 Below is a complete example for a specification derived from this mixin. This code is from 
 package org.justceyin.specifications.examples within this module.
 
 \`\`\`
 \"An example specification illustrating how to go about creating a declarative specification defined in
  terms of named requirements, where each requirement uses the fluent interface of org.justceyin.expectations
  to declare an expected result for one or more inputs going through zero or more setup/transform steps.\"
 shared class IntegerStackDeclarativeSpecification()
     satisfies DeclarativeSpecification
 { 
    
     shared actual String title = \"IntegerStackDeclarativeSpecification\"; 
    
     // starting values
     Stack<Integer> anEmptyStack() => Stack<Integer>();
     Stack<Integer> aStackOfOne() => Stack<Integer>().push(1);
     Stack<Integer> aStackOfTwoOne() => Stack<Integer>().push(1).push(2);
    
     // constraints
     value anIntegerStack = StackConstraints<Integer>();
    
    // requirements
     shared actual {<String->Requirement>+} requirements = {
        
         \"A stack starts out empty.\"->
         StartingFrom( anEmptyStack ).expect( anIntegerStack.thatIsEmpty ),
        
         \"Pushing then popping leaves the original stack.\"->
         StartingFrom( anEmptyStack ).after( pushOntoStack(1) ).followedBy( popStack<Integer> ).expect( anIntegerStack.thatIsEmpty ),
        
         \"A stack with one item is empty after popping that item.\"->
         StartingFrom( aStackOfOne ).after( popStack<Integer> ).expect( anIntegerStack.thatIsEmpty ),
        
         \"A stack with two items is empty after popping both items.\"->
         StartingFrom( aStackOfTwoOne ).after( popStack<Integer> ).followedBy( popStack<Integer> ).expect( anIntegerStack.thatIsEmpty ),
        
         \"The top of a stack with one value yields that value.\"->
         StartingFrom( aStackOfOne ).after( topOfStack<Integer> ).expect( anInteger.withValue(1) ),
        
         \"The top of a stack with two values yields the last pushed value.\"->
         StartingFrom( aStackOfTwoOne ).after( topOfStack<Integer> ).expect( anInteger.withValue(2) ),
        
         \"A pushed value becomes the new top of the stack.\"->
         StartingFromAnyOf( {anEmptyStack,aStackOfOne,aStackOfTwoOne} ).after( pushOntoStack(100) ).expect( anIntegerStack.withTop(100) ),
        
         \"A pushed value becomes the new top of the stack.\"->
         StartingFrom( anEmptyStack ).or( aStackOfOne ).or( aStackOfTwoOne ).after( pushOntoStack(100) ).followedBy( topOfStack<Integer> ).expect( anInteger.withValue(100) ),
        
         \"Popping from an empty stack throws an exception.\"->
         StartingFrom( anEmptyStack ).after( popStack<Integer> ).expectAnException<EmptyStackException>(),

         \"Reading the top of an empty stack throws an exception.\"->
         StartingFrom( anEmptyStack ).after( topOfStack<Integer> ).expectAnException<EmptyStackException>(),
        
         \"Reading the 'if present' top of an empty stack yields null.\"->
         StartingFrom( anEmptyStack ).after( topOfStackIfPresent<Integer> ).expectNonexistentResult()

     };
    
 }
 \`\`\` 
"
by "Martin E. Nordberg III"
shared interface DeclarativeSpecification 
    satisfies Specification
{
    
    "The title of this specification."
    shared formal String title;
        // TBD: Derive the title from the doc annotation (M6) of a derived class
    
    // TBD: results in compiler bug
//    "A shorthand for a requirement entry (titled requirement)."
//    shared alias RequirementEntry => String->Requirement;
    
    // TBD: results in compiler bug
//    "A shorthand for multiple requirement entries."
//    shared alias RequirementEntries => {<String->Requirement>+};
    
    "The individual requirement statements making up this larger specification."
    shared formal {<String->Requirement>+} requirements;

    "Checks whether all the requirements within this specification are met."
    shared actual default ConstraintCheckResult check() {

        // Helper function for checking that a requirement is satisfied."
        ConstraintCheckResult checkRequirementEntry( String->Requirement requirement ) =>
            requirement.item.check( requirement.key );

        return ConstraintCheckComposite( title, requirements.collect( checkRequirementEntry ) );
    }

}
