/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 15.12.11
 * Time: 11:45
 */
package com.atgrand.functional {
import com.atgrand.testing.bdd.base.Specifications;

public class ClosureTest extends Specifications{
    [Test]
    public function should_return_closure_of_function():void {
        var f:Function = function modulo3(x:int):int {
            return x % 3;
        };
                
        var mod8by3:Function = closure(f, 8);
        it(mod8by3()).should.equal(2);
    }
}
}
