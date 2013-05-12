package com.atgrand.functional.collections {
import com.atgrand.functional.IFunkObject;

public interface IFuncIterator extends IFunkObject {
    function get hasNext():Boolean;

    function next():*;

    function get toArray():Array;

    function get toList():IFuncList;
}
}