

"A buffered scanner for given input characters with given look ahead distance and back up distance."
by "Martin E. Nordberg III"
shared class Scanner(
    "The forward size of the buffer of scanned characters"
    Integer lookAheadSize,
    "The backward size of the buffer of scanned characters"
    Integer lookBehindSize,
    "The raw input"
    Iterator<Character> input
)
    extends AbstractScanner<ScannedCharacter>( lookAheadSize, lookBehindSize, input)
{
    "Class defining a character returned from the scanner, including its source in the input."
    shared actual class ScannedCharacter(
        "Index into the scanner's buffer where the character is held temporarily."
        Integer index
    )
        extends super.ScannedCharacter( index )
    {
    }

}
