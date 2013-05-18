
import org.justceyin.expectations.constraints {
    ConstraintCheckResult, 
    ConstraintCheckComposite
}

"Specification composed of multiple sub-specifications."
by "Martin E. Nordberg III"
shared class CompositeSpecification( {Specification*} specifications ) 
    satisfies Specification
{

    "The child specifications within this specification."
    shared {Specification*} childSpecifications = specifications;
    
    "The title of this specification."
    shared String title = "TBD: Composite Specification";
        // TBD: Derive the title from the doc annotation (M6) of a derived class
    
    "Executes all the child specifications and combines them into a composite result."
    shared actual ConstraintCheckResult check() {
        return ConstraintCheckComposite( title, this.childSpecifications.collect( checkSpecification ) );
    }

}
