package com.atgrand.functional.collections {

public function toList(value:*):IList {
    var l:IList = nil;
    var n:int;

    if (value is IList) {
        return value
    }
    else if (value is String) {
        var string:String = String(value);
        n = string.length;

        while (--n > -1) {
            l = l.prepend(string.substr(n, 1))
        }

        return l
    }
    else {
        return list(value)
    }
}
}