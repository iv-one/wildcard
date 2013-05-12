package com.atgrand.functional.util {
import com.atgrand.functional.IFunkObject;

public function eq(a:*, b:*):Boolean {
    const aIsFunk:Boolean = a is IFunkObject;
    const bIsFunk:Boolean = b is IFunkObject;

    if (aIsFunk && bIsFunk) {
        return IFunkObject(a).equals(IFunkObject(b))
    }
    else {
        return a == b
    }
}
}