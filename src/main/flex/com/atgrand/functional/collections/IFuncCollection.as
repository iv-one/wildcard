package com.atgrand.functional.collections {
public interface IFuncCollection extends IFuncIterable {
    /**
     * The length of the collection.
     */
    [Deprecated(replacement="size", since="1.0")] function get length():int

    /**
     * The total number of elements in the collection.
     */
    function get size():int

    /**
     * Whether or not the size of the collection is known.
     */
    function get hasDefinedSize():Boolean

    /**
     * The elements of the collection stored in an array.
     */
    function get toArray():Array

}
}