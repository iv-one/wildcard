/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 23.07.12
 * Time: 16:33
 */
package com.atgrand.functional {

public interface ICompositeWildcard {
    /**
     * Return composite of functions
     * @return f || f(g(h(...)))
     */
    function get f():Function;
}
}
