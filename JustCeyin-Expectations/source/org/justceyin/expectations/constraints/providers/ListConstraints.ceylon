
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Mixin class defines constraints on a list."
by "Martin E. Nordberg III"
shared interface ListConstraints<T,U> 
    satisfies CollectionConstraints<T,U>
    given T satisfies List<U>
{
    
    "Returns a constraint that checks that a list has a given size."
    shared Constraint<T> withSize( 
        "The expected size of the list."
        Integer expectedSize 
    ) {
        return AdjectivalConstraint<T>( 
            (T list) => list.size == expectedSize,
            "of size ``expectedSize``"
        );
    }
    
}
