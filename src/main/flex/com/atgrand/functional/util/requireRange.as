package com.atgrand.functional.util {
public function requireRange(i:int, end:int, start:int = 0):void {
    if (i < start || i >= end) {
        throw new RangeError("Index " + i + " is out of range.")
    }
}
}