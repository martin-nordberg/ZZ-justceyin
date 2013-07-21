
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Concrete object providing constraints on single characters."
by "Martin E. Nordberg III"
shared object aCharacter
    extends ComparableConstraints<Character>()
{
    
    "Returns a constraint that checks that a character is lower case."
    shared Constraint<Character> thatIsLowerCase =>
        AdjectivalConstraint<Character>( 
            (Character character) => character.lowercase,
            "lower case"
        );
    
    "Returns a constraint that checks that a character is upper case."
    shared Constraint<Character> thatIsUpperCase =>
        AdjectivalConstraint<Character>( 
            (Character character) => character.uppercase,
            "upper case"
        );
    
}
