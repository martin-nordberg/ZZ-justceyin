
"Recognizer for a left bracket character ('[')."
shared class LeftBracket<Language>()
    extends OneCharacterRecognizer<Language>( '[' )
{
    shared actual class Token() extends super.Token() {}
}
