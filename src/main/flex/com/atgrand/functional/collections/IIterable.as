package com.atgrand.functional.collections {
import com.atgrand.functional.IFunkObject;

public interface IIterable extends IFunkObject {
    function get iterator():IIterator
}
}