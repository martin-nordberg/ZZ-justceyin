
"Interface to a token representing a literal value (like a number or string)."
shared interface LiteralValueToken<V>
    satisfies Token
{

    "The value represented by the token."
    shared formal V literalValue;

}
