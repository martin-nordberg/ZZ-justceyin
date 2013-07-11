
"Recognizer for a left brace character ('{')."
shared class LeftBrace<Language>()
    extends OneCharacterRecognizer<Language>( '{' )
{
    shared actual class Token() extends super.Token() {}
}
