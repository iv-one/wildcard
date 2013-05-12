package com.atgrand.functional.collections.immutable {
import com.atgrand.functional.IFunkObject
import com.atgrand.functional.collections.IFuncIterator
import com.atgrand.functional.collections.IFuncList
import com.atgrand.functional.collections.IteratorUtil
import com.atgrand.functional.collections.list
import com.atgrand.functional.collections.nil
import com.atgrand.functional.error.NoSuchElementError
import com.atgrand.functional.option.IOption
import com.atgrand.functional.option.none
import com.atgrand.functional.option.some

/**
 * The ListIterator class is the companion iterator implementation
 * for the List class.
 *
 * @private
 */
internal final class ListIterator implements IFuncIterator {
    private var _list:IFuncList

    /**
     * Creates a new ListIterator object.
     *
     * @private
     * @param list The backing list.
     */
    public function ListIterator(list:IFuncList) {
        _list = list
    }

    /**
     * @inheritDoc
     */
    public function get hasNext():Boolean {
        return _list.nonEmpty
    }

    /**
     * @inheritDoc
     */
    public function next():* {
        if (_list == nil) {
            throw new NoSuchElementError()
        }

        const head:* = _list.head

        _list = _list.tail

        return head
    }

    /**
     * @inheritDoc
     */
    public function equals(that:IFunkObject):Boolean {
        return IteratorUtil.eq(this, that)
    }

    /**
     * @inheritDoc
     */
    public function toString():String {
        return "[ListIterator]"
    }

    /**
     * @inheritDoc
     */
    public function get toArray():Array {
        return IteratorUtil.toArray(this)
    }

    /**
     * @inheritDoc
     */
    public function get toList():IFuncList {
        return IteratorUtil.toList(this)
    }
}
}