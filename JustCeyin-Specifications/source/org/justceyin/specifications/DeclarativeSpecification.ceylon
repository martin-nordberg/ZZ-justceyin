
import org.justceyin.expectations.constraints {
    ConstraintCheckResult, 
    ConstraintCheckComposite
}
import org.justceyin.specifications.requirements { 
    Requirement 
}

"Specification mixin defined in terms of a number of declarative requirements."
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
