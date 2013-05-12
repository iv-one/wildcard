package com.atgrand.functional {
import com.atgrand.functional.util.isAbstract

public final class pass {
    public static function any(value:*):Function {
        return function ():* { return value }
    }

    public static function string(value:String):Function {
        return function ():String { return value }
    }

    public static function bool(value:Boolean):Function {
        return function ():Boolean { return value }
    }

    public static function integer(value:int):Function {
        return function ():int { return value }
    }

    public static function unsignedInteger(value:uint):Function {
        return function ():uint { return value }
    }

    public static function number(value:Number):Function {
        return function ():Number { return value }
    }

    public static function xml(value:XML):Function {
        return function ():XML { return value }
    }

    public static function object(object:Object):Function {
        return function ():Object { return object }
    }

    public static function instanceOf(klass:Class):Function {
        return function (... rest):Object {
            return rest.length > 0 ? new klass(rest[0]) : new klass;
        }
    }

    public static function klass(klass:Class):Function {
        return function ():Class { return klass }
    }

    [Abstract]
    public function pass() { isAbstract() }
}
}