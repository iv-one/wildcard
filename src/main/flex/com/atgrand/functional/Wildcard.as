package com.atgrand.functional {

import com.atgrand.functional.util.eq;
import com.atgrand.functional.util.ne;

import flash.utils.Proxy;
import flash.utils.flash_proxy;

use namespace flash_proxy;

/**
 * The Wildcard class represents an instance of &quot;_&quot;.
 *
 */
internal final dynamic class Wildcard extends Proxy {

    override flash_proxy function getDescendants(name:*):* {
        return new CompositeWildcard(this.getProperty(name));
    }

    /**
     * @inheritDoc
     */
    flash_proxy override function callProperty(name:*, ... args):* {
        return function (x:*):* {
            return x[name].apply(x, args)
        }
    }

    /**
     * @inheritDoc
     */
    flash_proxy override function getProperty(name:*):* {
        return function (x:*):* {
            return x[name];
        }
    }

    override flash_proxy function hasProperty(name:*):Boolean {
        return false;
    }

    /**
     * The function <code>f</code> with <code>f(x) =
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = y not contain x</code>.
     */
    public function notIn(value:Array):Function {
        return function (x:*, ... rest):Boolean {
            return value.indexOf(x) == -1;
        }
    }

    public const nil:Function = function (... rest):void {
        // none
    };

    /**
     * The function <code>f</code> with <code>f(x) = ~x</code>.
     */
    public const binaryNot:Function = function (x:*):* {
        return ~x;
    };

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x - y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x - y</code>.
     */
    public function decrementBy(value:Number):Function {
        return function (x:Number):Number {
            return x - value
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x / y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x / y</code>.
     */
    public function divideBy(value:Number):Function {
        return function (x:Number):Number {
            return x / value
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = eq(x, y)</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = eq(x, y)</code>.
     */
    public function equals(value:*):Function {
        return function (x:*):Boolean {
            return eq(x, value)
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x.y</code>.
     *
     * @param property The property <code>y</code> of <code>x</code>.
     * @return The function <code>f</code> with <code>f(x) = x.y</code>.
     */
    public function get(property:String):Function {
        return function (x:*):* {
            return x[property]
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x >= y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x >= y</code>.
     */
    public function greaterEqual(value:*):Function {
        return function (x:*):Boolean {
            return x >= value
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x > y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x > y</code>.
     */
    public function greaterThan(value:*):Function {
        return function (x:*):Boolean {
            return x > value
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x + y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x + y</code>.
     */
    public function incrementBy(value:Number):Function {
        return function (x:Number):Number {
            return x + value
        }
    }

    /**
     * Creates and returns the function <code>f</code> to test if <code>x</code>
     * is in [minValue, maxValue].
     *
     * @param minValue The inclusive start of the range.
     * @param maxValue The inclusive end of the range.
     * @return The function <code>f</code> to test if <code>x</code>
     * is in [minValue, maxValue].
     */
    public function inRange(minValue:Number, maxValue:Number):Function {
        return function (x:*):Boolean {
            return minValue <= x && x <= maxValue
        }
    }

    /**
     * The function <code>f</code> with <code>f(x) = IActivableObject(x).active</code>.
     */
    public const isActive:Function = function (x:IActivableObject, ... rest):Boolean {
        return x.active
    };

    /**
     * The function <code>f</code> with <code>f(x) = ISelectableObject(x).selected</code>.
     */
    public const isSelected:Function = function (x:ISelectableObject, ... rest):Boolean {
        return x.selected
    };

    /**
     * The function <code>f</code> with <code>f(x) = x % 2 == 0</code>.
     */
    public const isEven:Function = function (x:Number):Boolean {
        const asInt:int = int(x);

        if (0 != (x - asInt)) {
            return false
        }

        return (asInt & 1) == 0
    };

    /**
     * The function <code>f</code> with <code>f(x) = x % 2 != 0</code>.
     */
    public const isOdd:Function = function (x:Number):Boolean {
        const asInt:int = int(x);

        if (0 != (x - asInt)) {
            return false
        }

        return (asInt & 1) != 0
    };

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x <= y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x <= y</code>.
     */
    public function lessEqual(value:*):Function {
        return function (x:*):Boolean {
            return x <= value
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x < y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x < y</code>.
     */
    public function lessThan(value:*):Function {
        return function (x:*):Boolean {
            return x < value
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x % y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x % y</code>.
     */
    public function moduloBy(value:Number):Function {
        return function (x:Number):Number {
            return x % value
        }
    }

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = x ~~ y</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = x ~~ y</code>.
     */
    public function multiplyBy(value:Number):Function {
        return function (x:Number):Number {
            return x * value
        }
    }

    /**
     * The function <code>f</code> with <code>f(x) = !x</code>.
     */
    public const not:Function = function (x:*, ... rest):Boolean {
        return !x
    };

    /**
     * Creates and returns the function <code>f</code> with <code>f(x) = ne(x, y)</code>.
     *
     * @param value The value for <code>y</code>.
     * @return The function <code>f</code> with <code>f(x) = ne(x, y)</code>.
     */
    public function notEquals(value:*):Function {
        return function (x:*, ... rest):Boolean {
            return ne(x, value)
        }
    }

    /**
     * The function <code>f</code> with <code>f(x) = x ? true : false</code>.
     */
    public const toBoolean:Function = function (x:*):Boolean {
        return x ? true : false
    };

    /**
     * The function <code>f</code> with <code>f(x) = x.toLowerCase()</code>.
     */
    public const toLowerCase:Function = function (x:*):String {
        return x is String ? String(x).toLowerCase() : ("" + x).toLowerCase()
    };

    /**
     * The function <code>f</code> with <code>f(x) = x.toString()</code>.
     */
    public const toString:Function = function (x:*):String {
        return "" + x
    };

    /**
     * The function <code>f</code> with <code>f(x) = x.toUpperCase()</code>.
     */
    public const toUpperCase:Function = function (x:*):String {
        return x is String ? String(x).toUpperCase() : ("" + x).toUpperCase()
    };

    /**
     * The function <code>f</code> with <code>f(x) = toList(x)</code>.
     */
    public const toList:Function = function (x:*):String {
        return toList(x)
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x + y</code>.
     */
    public const plus_:Function = function (a:*, b:*):* {
        return a + b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x - y</code>.
     */
    public const minus_:Function = function (a:*, b:*):* {
        return a - b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x ~~ y</code>.
     */
    public const multiply_:Function = function (a:*, b:*):* {
        return a * b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x / y</code>.
     */
    public const divide_:Function = function (a:*, b:*):* {
        return a / b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x % y</code>.
     */
    public const modulo_:Function = function (a:*, b:*):* {
        return a % b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x < y</code>.
     */
    public const lessThan_:Function = function (a:*, b:*):* {
        return a < b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x > y</code>.
     */
    public const greaterThan_:Function = function (a:*, b:*):* {
        return a > b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x >= y</code>.
     */
    public const greaterEqual_:Function = function (a:*, b:*):* {
        return a >= b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x <= y</code>.
     */
    public const lessEqual_:Function = function (a:*, b:*):* {
        return a <= b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x == y</code>.
     */
    public const equal_:Function = function (a:*, b:*):* {
        return eq(a, b)
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x != y</code>.
     */
    public const notEqual_:Function = function (a:*, b:*):* {
        return ne(a, b)
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x === y</code>.
     */
    public const strictlyEqual_:Function = function (a:*, b:*):* {
        return a == b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x !== y</code>.
     */
    public const strictlyNotEqual_:Function = function (a:*, b:*):* {
        return a !== b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x & y</code>.
     */
    public const binaryAnd_:Function = function (a:*, b:*):* {
        return a & b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x | y</code>.
     */
    public const binaryOr_:Function = function (a:*, b:*):* {
        return a | b
    };

    /**
     * The function <code>f</code> with <code>f(x, y) = x ^ y</code>.
     */
    public const binaryXor_:Function = function (a:*, b:*):* {
        return a ^ b
    };

    /**
     * The function <code>f</code> with <code>f(x) = new y(x)</code>
     */
    public function produce(clazz:Class):Function {
        return function (x:*):* {
            return new clazz(x);
        }
    }

    /**
     * The function <code>f</code> with <code>f(x) = new x()</code>
     */
    public const instantiate:Function = function (x:*, ... rest):* {
        return new x();
    };
}
}