/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 23.11.11
 * Time: 18:20
 */
package com.atgrand.functional.wildcard {

import com.atgrand.functional.ICompositeWildcard;

public function fun(f:*):Function {
    return f is ICompositeWildcard ? f.f : f;
}
}
