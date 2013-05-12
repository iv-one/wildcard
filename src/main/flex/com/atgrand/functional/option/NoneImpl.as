package com.atgrand.functional.option {

import com.atgrand.functional.IFunkObject;
import com.atgrand.functional.Product;
import com.atgrand.functional.error.NoSuchElementError;
import com.atgrand.functional.util.verifiedType;

/**
 * The NoneImpl class represents a companion object to the
 * <code>none</code> constant. This implies that there is only
 * one instance of the NoneImpl existing.
 *
 * @see com.atgrand.functional.option.none
 * @private
 */
internal final class NoneImpl extends Product implements IOption {
    /**
     * @inheritDoc
     */
    public function get get():* {
        throw new NoSuchElementError()
    }

    /**
     * @inheritDoc
     */
    public function getOrElse(f:Function):* {
        return f()
    }

    /**
     * @inheritDoc
     */
    public function get isDefined():Boolean {
        return false
    }

    /**
     * @inheritDoc
     */
    public function get isEmpty():Boolean {
        return true
    }

    /**
     * @inheritDoc
     */
    override public function equals(that:IFunkObject):Boolean {
        if (that is IOption) {
            return !IOption(that).isDefined
        }

        return false
    }

    /**
     * @inheritDoc
     */
    override public function get productArity():int {
        return 0
    }

    /**
     * @inheritDoc
     */
    override public function productElement(i:int):* {
        throw new RangeError()
    }

    /**
     * @inheritDoc
     */
    override public function get productPrefix():String {
        return "None"
    }

    /**
     * @inheritDoc
     */
    public function filter(f:Function):IOption {
        return this
    }

    /**
     * @inheritDoc
     */
    public function foreach(f:Function):void {
    }

    /**
     * @inheritDoc
     */
    public function flatMap(f:Function):IOption {
        return this
    }

    /**
     * @inheritDoc
     */
    public function map(f:Function):IOption {
        return this
    }

    /**
     * @inheritDoc
     */
    public function orElse(f:Function):IOption {
        return verifiedType(f(), IOption)
    }
}
}