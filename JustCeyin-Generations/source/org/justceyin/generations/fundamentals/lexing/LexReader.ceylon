

shared class LexReader(
    {Character*} input,
    String _streamName,
    Integer _line = 1,
    Integer _column = 1
) {
    shared Integer column = _column;
    shared Integer line = _line;
    shared String streamName = _streamName;
    
    "Reads one character; returns the character and a new reader with the remaining input."
    shared [Character,LexReader]? readChar() {
        value char = this.input.first;
        if ( exists char ) {
            if ( char == '\n' ) {
                return [char,LexReader(this.input.rest,streamName,this.line+1,0)];
            }
            return [char,LexReader(this.input.rest,streamName,this.line,this.column+1)];
        }
        return null;
    }
    
}



// TBD: Map character to indexed characters as follows:

{Character*} input = "Some text";

[Character,Integer] (Character) makeIndexer() {
    variable Integer index = 0;
    
    [Character,Integer] result( Character ch ) => [ch,index++];
    
    return result;
}

{[Character,Integer]*} indexedInput = input.map( makeIndexer() ); 


// TBD: take a pass through the input to find the line starting indexes; compute token line & column lazily from that
