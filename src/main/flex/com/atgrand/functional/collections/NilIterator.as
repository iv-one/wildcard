package com.atgrand.functional.collections {
import com.atgrand.functional.IFunkObject
import com.atgrand.functional.error.NoSuchElementError
import com.atgrand.functional.option.IOption
import com.atgrand.functional.option.none

internal final class NilIterator implements IFuncIterator {
    public static const INSTANCE:NilIterator = new NilIterator();

    /**
     * @inheritDoc
     */
    public function get hasNext():Boolean {
        return false
    }

    /**
     * @inheritDoc
     */
    public function next():* {
        throw new NoSuchElementError()
    }

    /**
     * @inheritDoc
     */
    public function get toArray():Array {
        return []
    }

    /**
     * @inheritDoc
     */
    public function get toList():IFuncList {
        return nil
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
        return "[NilIterator]"
    }
}
}