package com.atgrand.functional.util {
import com.atgrand.functional.error.AbstractMethodError

public function isAbstract():* {
    throw new AbstractMethodError()
}
}