package com.atgrand.functional {
import com.atgrand.functional.collections.IFuncIterator
import com.atgrand.functional.collections.IFuncList
import com.atgrand.functional.collections.IteratorUtil
import com.atgrand.functional.option.IOption
import com.atgrand.functional.option.none
import com.atgrand.functional.option.some

internal final class ProductIterator implements IFuncIterator {
    private var _product:IProduct;
    private var _arity:int;
    private var _index:int = 0;

    public function ProductIterator(product:IProduct) {
        _product = product;
        _arity = product.productArity
    }

    /**
     * @inheritDoc
     */
    public function get hasNext():Boolean {
        return _index < _arity
    }

    public function next():* {
        return _product.productElement(_index++)
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
    public function get toArray():Array {
        return IteratorUtil.toArray(this)
    }


    /**
     * @inheritDoc
     */
    public function get toList():IFuncList {
        return IteratorUtil.toList(this)
    }

    /**
     * @inheritDoc
     */
    public function toString():String {
        return "[ProductIterator]"
    }
}
}