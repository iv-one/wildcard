package com.atgrand.functional.test {
import flexunit.framework.Assert;

public function assertThrows(f:Function, type:Class):void {
    var errorThrown:Boolean;

    try {
        f()
        errorThrown = false
    }
    catch (error:*) {
        errorThrown = (error is type)
    }

    if (!errorThrown) {
        Assert.fail("Error of type " + type + " expected.")
    }
}
}