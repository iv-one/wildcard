package com.atgrand.functional.collections {
import com.atgrand.functional.util.require

public final class Range {
    public static function to(start:int, end:int):IFuncList {
        require(start < end, "Start must be less than end.");

        const m:int = start - 1;
        var n:int = end + 1;
        var l:IFuncList = nil;

        while (--n > m) {
            l = l.prepend(n)
        }

        return l
    }

    public static function until(start:int, end:int):IFuncList {
        require(start < end, "Start must be less than end.");

        const m:int = start - 1;
        var n:int = end;
        var l:IFuncList = nil;

        while (--n > m) {
            l = l.prepend(n)
        }

        return l
    }
}
}