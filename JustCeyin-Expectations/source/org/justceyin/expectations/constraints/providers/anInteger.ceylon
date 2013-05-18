
"Concrete object providing constraints on integers."
by "Martin E. Nordberg III"
shared object anInteger 
    extends ComparableConstraints<Integer>()
    satisfies NumberConstraints<Integer> & IntegralConstraints<Integer>
{

}
