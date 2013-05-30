
import ceylon.file { 
    Directory, 
    Nil,
    Path
}

"Creates a directory if it does not already exist."
shared Directory createDirectoryIfNeeded( Path path ) {

    value resource = path.resource;
    
    switch ( resource )
      case ( is Directory ) {
          return resource;
      }
      case ( is Nil ) {
          createDirectoryIfNeeded( path.parent );
          return resource.createDirectory();
      }
      else {
          throw Exception("Cannot create directory with same name as existing file: ``path.string``." );
      }

}