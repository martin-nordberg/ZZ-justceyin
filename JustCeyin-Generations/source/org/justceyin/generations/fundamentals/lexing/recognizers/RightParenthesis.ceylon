
"Recognizer for a right parenthesis character (')')."
shared class RightParenthesis<Language>()
    extends OneCharacterRecognizer<Language>( ')' )
{
    shared actual class Token() extends super.Token() {}
}
