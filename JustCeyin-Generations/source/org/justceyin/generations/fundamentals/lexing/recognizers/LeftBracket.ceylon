
"Recognizer for a left bracket character ('[')."
shared class LeftBracket()
    extends OneCharacterRecognizer( '[' )
{
    shared actual class Token() extends super.Token() {}
}
