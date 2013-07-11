
"Interface to a token representing a literal value (like a number or string)."
shared interface LiteralValueToken<Language,Value>
    satisfies Token<Language>
{

    "The value represented by the token."
    shared formal Value literalValue;

}
