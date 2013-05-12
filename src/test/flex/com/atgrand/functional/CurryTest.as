/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 15.12.11
 * Time: 11:57
 */
package com.atgrand.functional {
import com.atgrand.testing.bdd.base.Specifications;

public class CurryTest extends Specifications {
    [Test]
    public function should_return_curry_of_function():void {
        var f:Function = function modulo(x:int, y:int):int {
            return y % x;
        };

        var mod3:Function = curry(f, 3);
        it(mod3(8)).should.equal(2);
        it(mod3(9)).should.equal(0);
    }
}
}
