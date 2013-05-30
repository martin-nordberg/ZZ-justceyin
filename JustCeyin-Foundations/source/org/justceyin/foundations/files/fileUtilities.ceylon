
import ceylon.file { 
    File, 
    Nil, 
    Path, 
    Writer 
}

"Creates a writer for a file in a given path"
shared Writer createFileWriter( 
    "The path to the file to be written"
    Path path, 
    "Whether to append to an existing file"
    Boolean append = false, 
    "The encoding for the writer"
    String encoding = "UTF-8"
) {

    value resource = path.resource;
    
    switch ( resource )
      case ( is File ) {
          if ( append ) {
              return resource.appender( encoding );
          }
          return resource.writer( encoding );
      }
      case ( is Nil ) {
          return resource.createFile().writer( encoding );
      }
      else {
          throw Exception( "Cannot create file with same name as existing directory: ``path.string``." );
      }

}