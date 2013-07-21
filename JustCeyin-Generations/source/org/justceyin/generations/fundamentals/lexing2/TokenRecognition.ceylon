

interface TokenRecognition
    of tokenRecognized | TokenRecognizing | tokenNotRecognized {
}

object tokenRecognized
    satisfies TokenRecognition
{
}

object tokenNotRecognized
    satisfies TokenRecognition
{
}

class TokenRecognizing()
    satisfies TokenRecognition
{
}

