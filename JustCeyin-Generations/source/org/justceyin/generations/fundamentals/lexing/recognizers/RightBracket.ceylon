
"Recognizer for a right bracket character (']')."
shared class RightBracket<Language>()
    extends OneCharacterRecognizer<Language>( ']' )
{
    shared actual class Token() extends super.Token() {}
}
