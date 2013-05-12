package com.atgrand.functional.collections {

public function toList(value:*):IFuncList {
    var l:IFuncList = nil;
    var n:int;

    if (value is IFuncList) {
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