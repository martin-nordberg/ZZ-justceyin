
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint,
    BasicConstraint, 
    Constraint
}

///////////////////////////////////////////////////////////////////////////////

"Exception thrown when trying to pop from an empty stack."
shared class EmptyStackException() extends Exception() {}
    
///////////////////////////////////////////////////////////////////////////////

"Class to be tested - classic immutable stack implementation."
shared class Stack<T>( [T*] initialElements = [] ) {
        
    "The elements in the stack (first element is last in)."
    [T*] elements = initialElements;
        
    "Determines whether this stack is empty."
    shared Boolean empty {
        return elements.empty;
    }
    
    "Takes the top value off the stack and returns a new stack with the remainder. 
     Throws an exception if the stack is empty."
    shared Stack<T> pop() {
        if ( elements.empty ) {
            throw EmptyStackException();
        }
        return Stack( elements.rest );
    }
    
    "Pushes a new value on to the stack."
    shared Stack<T> push( T element ) {
        return Stack( [element, *elements] );
    }
    
    "Returns the top value from the stack. Throws an exception if the stack is empty."
    shared T top { 
        if ( exists t=elements.first ) {
            return t;
        }
        throw EmptyStackException();
    }

    "Returns the top value from the stack, if any."
    shared T? topIfPresent { 
        return elements.first;
    }

}

///////////////////////////////////////////////////////////////////////////////

// Top level helper functions for functional style programming with stacks
 
shared Boolean emptyStack<T>( Stack<T> stack ) => stack.empty;
shared Stack<T> popStack<T>( Stack<T> stack ) => stack.pop();
shared Stack<T> pushOntoStack<T>( T element )( Stack<T> stack ) => stack.push( element );
shared T topOfStack<T>( Stack<T> stack ) => stack.top;
shared T? topOfStackIfPresent<T>( Stack<T> stack ) => stack.topIfPresent;

///////////////////////////////////////////////////////////////////////////////

"Class defining common constraints on stacks for use in preconditions, postconditions, or specifications."
shared class StackConstraints<T>()
    given T satisfies Object
{
        
    "Returns a constraint that checks that a stack is empty."
    shared Constraint<Stack<T>> thatIsEmpty =>
        AdjectivalConstraint<Stack<T>>( (Stack<T> stack) => stack.empty, "empty" );

    "Returns a constraint that checks that a stack is not empty."
    shared Constraint<Stack<T>> thatIsNotEmpty =>
        AdjectivalConstraint<Stack<T>>( (Stack<T> stack) => !stack.empty, "not empty" );

    "Returns a constraint that checks that a stack is not empty."
    shared Constraint<Stack<T>> withTop( T expectedValue ) =>
        BasicConstraint<Stack<T>>( 
            (Stack<T> stack) {
                if ( exists top=stack.topIfPresent ) { return top == expectedValue; } else { return false; }
            },
            (String valueName) { 
                return "Verified ``valueName`` has top ``expectedValue``.";
            },
            (Stack<T> stack, String valueName) {
                if ( exists top=stack.topIfPresent ) {
                    return "Expected ``valueName`` to have top ``expectedValue``, but was ``top``.";
                }
                return "Expected ``valueName`` to have top ``expectedValue``, but was empty.";
            },
            (Stack<T> stack, String valueName) { 
                return "An exception occurred while checking whether ``valueName`` has top ``expectedValue``.";
            }
        );

}

