
"Recognizer for a left brace character ('{')."
shared class LeftBrace()
    extends OneCharacterRecognizer( '{' )
{
    shared actual class Token() extends super.Token() {}
}
