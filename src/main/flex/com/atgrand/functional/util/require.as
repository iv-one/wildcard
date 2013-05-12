package com.atgrand.functional.util {
public function require(condition:Boolean, message:String):void {
    if (!condition) {
        throw new ArgumentError(message)
    }
}
}