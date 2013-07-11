
"Recognizer for a right brace character ('}')."
shared class RightBrace<Language>()
    extends OneCharacterRecognizer<Language>( '}' )
{
    shared actual class Token() extends super.Token() {}
}
