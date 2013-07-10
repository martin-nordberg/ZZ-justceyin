
"Recognizer for a right brace character ('}')."
shared class RightBrace()
    extends OneCharacterRecognizer( '}' )
{
    shared actual class Token() extends super.Token() {}
}
