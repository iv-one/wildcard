package com.atgrand.functional {
import com.atgrand.functional.collections.IIterable

public interface IProduct extends IImmutable, IFunkObject, IIterable {
    function get productArity():int

    function productElement(i:int):*

    function get productPrefix():String

    function mkString(separator:String):String
}
}