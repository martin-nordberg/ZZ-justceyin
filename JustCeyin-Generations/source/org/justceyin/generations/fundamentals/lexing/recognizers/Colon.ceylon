
"Recognizer for a colon character (':')."
shared class Colon<Language>()
    extends OneCharacterRecognizer<Language>( ':' )
{
    shared actual class Token() extends super.Token() {}
}
