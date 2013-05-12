package com.atgrand.functional.collections {
import com.atgrand.functional.IFunkObject
import com.atgrand.functional.util.isAbstract
import com.atgrand.functional.util.ne

public final class IteratorUtil {
    public static function eq(thisIter:IIterator, that:IFunkObject):Boolean {
        if (that is IIterator) {
            const thatIter:IIterator = IIterator(that);
            var thisHasNext:Boolean;
            var thatHasNext:Boolean;

            while (true) {
                thisHasNext = thisIter.hasNext;
                thatHasNext = thatIter.hasNext;

                if (thisHasNext && thatHasNext) {
                    if (ne(thisIter.next(), thatIter.next())) {
                        return false
                    }
                } else if (!thisHasNext && !thatHasNext) {
                    break
                }
                else {
                    return false
                }
            }

            return true
        }

        return false
    }

    public static function toArray(iter:IIterator):Array {
        const array:Array = [];

        while (iter.hasNext) {
            array.push(iter.next())
        }

        return array
    }

    public static function toList(iter:IIterator):IList {
        var l:IList = nil;

        while (iter.hasNext) {
            l = l.prepend(iter.next())
        }

        return l.reverse
    }

    [Abstract]
    public function IteratorUtil() { isAbstract() }
}
}