package com.atgrand.functional.collections {
import com.atgrand.functional.IFunkObject
import com.atgrand.functional.option.IOption

public interface IIterator extends IFunkObject {
    function get hasNext():Boolean;

    function next():*;

    function get toArray():Array;

    function get toList():IList;
}
}