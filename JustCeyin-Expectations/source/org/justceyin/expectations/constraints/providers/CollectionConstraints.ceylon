
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Mixin class defines constraints on a collection."
by "Martin E. Nordberg III"
shared interface CollectionConstraints<T,U> 
    given T satisfies Collection<U>
{
    
    "Returns a constraint that checks that a collection is empty."
    shared Constraint<T> thatIsEmpty => 
        AdjectivalConstraint<T>( (T collection) => collection.empty, "empty" );

    "Returns a constraint that checks that a collection is not empty."
    shared Constraint<T> thatIsNotEmpty => 
        AdjectivalConstraint<T>( (T collection) => !collection.empty, "not empty" );

}
