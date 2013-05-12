package com.atgrand.functional.option {
import com.atgrand.functional.IFunkObject
import com.atgrand.functional.Product;
import com.atgrand.functional.util.eq
import com.atgrand.functional.util.verifiedType;

/**
 * The SomeImpl class represents a companion object to the <code>some</code>
 * function.
 *
 * @see com.atgrand.functional.option.some
 * @private
 */
internal final class SomeImpl extends Product implements IOption {
    /**
     * Private backing variable for the <code>get</code> property.
     */
    private var _value:*;

    /**
     * @inheritDoc
     */
    public function SomeImpl(value:*) {
        _value = value
    }

    /**
     * @inheritDoc
     */
    public function get get():* {
        return _value
    }

    /**
     * @inheritDoc
     */
    public function getOrElse(f:Function):* {
        return _value
    }

    /**
     * @inheritDoc
     */
    public function get isDefined():Boolean {
        return true
    }

    /**
     * @inheritDoc
     */
    public function get isEmpty():Boolean {
        return false
    }

    /**
     * @inheritDoc
     */
    override public function equals(that:IFunkObject):Boolean {
        if (that is IOption) {
            const thatOption:IOption = IOption(that);

            if (thatOption.isDefined) {
                return eq(get, thatOption.get)
            }
        }

        return false
    }

    /**
     * @inheritDoc
     */
    override public function get productArity():int {
        return 1;
    }

    /**
     * @inheritDoc
     */
    override public function productElement(i:int):* {
        if (i == 0)
            return get;
        throw new RangeError()
    }

    /**
     * @inheritDoc
     */
    override public function get productPrefix():String {
        return "Some";
    }

    /**
     * @inheritDoc
     */
    public function filter(f:Function):IOption {
        return f(get) === true ? this : none;
    }

    /**
     * @inheritDoc
     */
    public function foreach(f:Function):void {
        f(get)
    }

    /**
     * @inheritDoc
     */
    public function flatMap(f:Function):IOption {
        return verifiedType(f(get), IOption)
    }

    /**
     * @inheritDoc
     */
    public function map(f:Function):IOption {
        return some(f(get))
    }

    /**
     * @inheritDoc
     */
    public function orElse(f:Function):IOption {
        return this
    }
}
}