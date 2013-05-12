package com.atgrand.functional {
import com.atgrand.functional.collections.IFuncIterable

public interface IProduct extends IImmutable, IFunkObject, IFuncIterable {
    function get productArity():int

    function productElement(i:int):*

    function get productPrefix():String

    function mkString(separator:String):String
}
}