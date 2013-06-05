
import ceylon.time {
    Date,
    date,
    DateTime,
    dateTime, 
    rightNow = now,
    todaysDate = today
}
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Computes the first millisecond of the current date."
DateTime todayStartOfDay() {
    Date baseDate = todaysDate();
    return dateTime( baseDate.year, baseDate.month, baseDate.day );
}

"Computes the last millisecond of the current date."
DateTime todayEndOfDay() {
    Date baseDate = todaysDate();
    return dateTime( baseDate.year, baseDate.month, baseDate.day, 23, 59, 59, 999 );
}

"Concrete object providing constraints on date/times."
by "Martin E. Nordberg III"
shared object aDateTime
    extends ComparableConstraints<DateTime>()
{
        
    "Returns a constraint that checks that a date time is in the future."
    shared Constraint<DateTime> afterNow =>
        AdjectivalConstraint<DateTime>( (DateTime actualValue) => actualValue > rightNow().dateTime(), "after now" );

    "Returns a constraint that checks that a date time is on a future date."
    shared Constraint<DateTime> afterToday =>
        AdjectivalConstraint<DateTime>( (DateTime actualValue) => actualValue > todayEndOfDay(), "after today" );

    "Returns a constraint that checks that a date time is in the past."
    shared Constraint<DateTime> beforeNow =>
        AdjectivalConstraint<DateTime>( (DateTime actualValue) => actualValue < rightNow().dateTime(), "before now" );

    "Returns a constraint that checks that a date time is on a past date."
    shared Constraint<DateTime> beforeToday =>
        AdjectivalConstraint<DateTime>( (DateTime actualValue) => actualValue < todayStartOfDay(), "before today" );

    "Returns a constraint that checks that a date time is today or in the future."
    shared Constraint<DateTime> onOrAfterToday =>
        AdjectivalConstraint<DateTime>( (DateTime actualValue) => actualValue >= todayStartOfDay(), "on or after today" );

    "Returns a constraint that checks that a date time is today or in the past."
    shared Constraint<DateTime> onOrBeforeToday =>
        AdjectivalConstraint<DateTime>( (DateTime actualValue) => actualValue <= todayEndOfDay(), "on or before today" );

    "Returns a constraint that checks that a date time is today (any time)."
    shared Constraint<DateTime> today =>
        AdjectivalConstraint<DateTime>( (DateTime actualValue) => date(actualValue.year,actualValue.month,actualValue.day) == todaysDate(), "today" );

}
