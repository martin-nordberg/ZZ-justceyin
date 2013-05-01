
import ceylon.time {
    Date, 
    todaysDate = today
}
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Concrete object with constraints on dates."
by "Martin E. Nordberg III"
shared object aDate
    extends ComparableConstraints<Date>()
{
        
    "Returns a constraint that checks that a date is in the future."
    shared Constraint<Date> afterToday =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue > todaysDate(), "after today" );

    "Returns a constraint that checks that a date is in the past."
    shared Constraint<Date> beforeToday =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue < todaysDate(), "before today" );

    "Returns a constraint that checks that a date is today or in the future."
    shared Constraint<Date> onOrAfterToday =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue >= todaysDate(), "on or after today" );

    "Returns a constraint that checks that a date is today or in the past."
    shared Constraint<Date> onOrBeforeToday =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue <= todaysDate(), "on or before today" );

    "Returns a constraint that checks that a date is today."
    shared Constraint<Date> today =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue == todaysDate(), "today" );

}
