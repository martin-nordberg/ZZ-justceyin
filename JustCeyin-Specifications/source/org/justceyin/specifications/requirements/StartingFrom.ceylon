
"Starting point for a fluent interface for declaring specifications."
by "Martin E. Nordberg III"
shared class StartingFrom<Input>(
    "Function providing a starting value for a requirement."
    Input startingValue() 
)
    extends StartingFromAnyOf<Input>( {startingValue} )
{
    
}
