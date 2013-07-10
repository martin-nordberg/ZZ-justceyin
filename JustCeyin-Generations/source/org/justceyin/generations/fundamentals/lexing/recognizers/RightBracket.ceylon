
"Recognizer for a right bracket character (']')."
shared class RightBracket()
    extends OneCharacterRecognizer( ']' )
{
    shared actual class Token() extends super.Token() {}
}
