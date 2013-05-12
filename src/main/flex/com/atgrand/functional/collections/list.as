package com.atgrand.functional.collections {

import com.atgrand.functional.util.isVector;

import mx.collections.IList;

public function list(...rest):com.atgrand.functional.collections.IList {
    var items:*;

    if (rest.length == 1) {
        const xs:* = rest[0];
        if (xs is Array)
            items = xs;
        else if (xs is mx.collections.IList)
            items = xs.toArray();
        else if (xs == null)
            items = [];
        else if (isVector(xs))
            items = xs;
        else
            items = [xs];
    } else {
        items = rest;
    }

    var result:com.atgrand.functional.collections.IList = nil;
    var n:int = items.length;

    while (--n > -1) {
        result = result.prepend(items[n])
    }

    return result
}
}