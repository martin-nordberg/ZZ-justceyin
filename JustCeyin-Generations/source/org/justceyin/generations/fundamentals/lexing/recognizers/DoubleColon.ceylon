
"Recognizer for a double colon token ('::')."
shared class DoubleColon<Language>()
    extends TwoCharacterRecognizer<Language>( "::" )
{
    shared actual class Token() extends super.Token() {}
}
