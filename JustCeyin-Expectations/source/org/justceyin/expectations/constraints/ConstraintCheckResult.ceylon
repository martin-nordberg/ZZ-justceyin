
"Abstract class that enumerates possible constraint checking outcomes: success, 
 failure, or unexpected exception."
by "Martin E. Nordberg III"
shared abstract class ConstraintCheckResult(
    "An output message summarizing the constraint checking result."
    String msg 
)
    of ConstraintCheckSuccess | ConstraintCheckFailure | 
       ConstraintCheckUnexpectedNull | ConstraintCheckUnexpectedException |
       ConstraintCheckComposite
{
	
	"Whether the constraint was checked successfully."
	shared default Boolean isSuccess = false;
	
	"Message describing the outcome of a constraint checking operation"
	shared String message = msg;
}


"Top level helper function determines whether a constraint was checked successfully."
by "Martin E. Nordberg III"
shared Boolean isSuccessConstraintCheckResult( 
    "The constraint heck result to be evaluated for success."
    ConstraintCheckResult constraintCheckResult 
) {
    return constraintCheckResult.isSuccess;
}


"Class representing a successful constraint checking outcome."
by "Martin E. Nordberg III"
shared class ConstraintCheckSuccess( 
    "An output message summarizing the successful constraint checking result."
    String msg 
)
    extends ConstraintCheckResult( msg ) {

	"Whether the constraint was checked successfully."
	shared actual Boolean isSuccess = true;
}


"Class representing a failed constraint outcome with a given message explaining the failure."
by "Martin E. Nordberg III"
shared class ConstraintCheckFailure( 
    "An output message summarizing the constraint checking failure."
    String msg 
) 
    extends ConstraintCheckResult( msg ) {

}


"Class representing a constraint outcome that was unexpectedly checked on a null value."
by "Martin E. Nordberg III"
shared class ConstraintCheckUnexpectedNull(
    "A message explaining the unexpected null value check."
    String msg 
) 
    extends ConstraintCheckResult( msg ) {

}


"Class representing a constraint outcome that unexpectedly threw an exception."
by "Martin E. Nordberg III"
shared class ConstraintCheckUnexpectedException( 
    "A message explaining the unexpected exception during the check."
    String msg, 
    "The exception thrown and caught."
    Exception e 
) 
    extends ConstraintCheckResult( msg ) {

    "The exception that was thrown unexpectedly."
    shared Exception exception = e;

}


"Class representing a composite constraint checking outcome."
by "Martin E. Nordberg III"
shared class ConstraintCheckComposite( 
    "A message summarizing the composite constraint checking result."
    String msg, 
    "A sequence of constraint checking results that are to be the children of this composite result."
    shared {ConstraintCheckResult*} constraintCheckResults 
)
    extends ConstraintCheckResult( msg ) {
    
    "The child constraint checking results of this composite result."
    shared {ConstraintCheckResult*} childConstraintCheckResults = constraintCheckResults; 

    "Whether the constraint was checked successfully, i.e. all children were successful."
    shared actual Boolean isSuccess = 
        childConstraintCheckResults.every( isSuccessConstraintCheckResult );

}

