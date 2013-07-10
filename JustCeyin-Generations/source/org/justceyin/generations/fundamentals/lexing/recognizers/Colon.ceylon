
"Recognizer for a colon character (':')."
shared class Colon()
    extends OneCharacterRecognizer( ':' )
{
    shared actual class Token() extends super.Token() {}
}
