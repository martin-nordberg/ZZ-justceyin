
import org.justceyin.foundations.util.internal {
    makeUuidImpl
}

shared interface Uuid {
    
}


shared Uuid makeUuid() {
    return makeUuidImpl();
}