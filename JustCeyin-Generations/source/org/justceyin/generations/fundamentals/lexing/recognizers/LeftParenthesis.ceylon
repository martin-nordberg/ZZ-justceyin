
"Recognizer for a left parenthesis character ('(')."
shared class LeftParenthesis<Language>()
    extends OneCharacterRecognizer<Language>( '(' )
{
    shared actual class Token() extends super.Token() {}
}
