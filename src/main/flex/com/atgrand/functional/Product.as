package com.atgrand.functional {
import com.atgrand.functional.collections.IIterator;
import com.atgrand.functional.util.isAbstract;
import com.atgrand.functional.util.ne;
import com.atgrand.functional.util.requireRange;

public class Product implements IProduct {
    [Abstract]
    public function get productArity():int { return isAbstract() }

    [Abstract]
    public function productElement(i:int):* { return isAbstract() }

    public function get productPrefix():String {
        return ""
    }

    public function equals(that:IFunkObject):Boolean {
        if (that is IProduct) {
            const thatProduct:IProduct = IProduct(that);

            if (productArity == thatProduct.productArity) {
                var n:int = productArity;

                while (--n > -1) {
                    if (ne(this.productElement(n), thatProduct.productElement(n))) {
                        return false
                    }
                }

                return true
            }
        }

        return false
    }

    /**
     * @inheritDoc
     */
    public function mkString(separator:String):String {
        const n:int = productArity;
        const m:int = n - 1;

        var buffer:String = "";
        var i:int;

        for (i = 0; i < n; ++i) {
            buffer += productElement(0);

            if (i != m) {
                buffer += separator
            }
        }

        return buffer
    }

    public function toString():String {
        if (0 == productArity) {
            return productPrefix
        }

        return productPrefix + "(" + mkString(",") + ")"
    }

    protected function validateIndex(i:int):void { requireRange(i, productArity) }

    public function get iterator():IIterator {
        return new ProductIterator(this)
    }
}
}