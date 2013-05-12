/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 15.12.11
 * Time: 15:41
 */
package com.atgrand.functional {
import com.atgrand.functional.collections.IFuncList;
import com.atgrand.functional.collections.Range;

public function range(from:int, to:int):IFuncList {
    return Range.to(from, to);
}
}
