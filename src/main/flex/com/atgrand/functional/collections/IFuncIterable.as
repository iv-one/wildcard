package com.atgrand.functional.collections {
import com.atgrand.functional.IFunkObject;

public interface IFuncIterable extends IFunkObject {
    function get iterator():IFuncIterator
}
}