/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 23.11.11
 * Time: 18:39
 */
package com.atgrand.functional.wildcard {
import com.atgrand.functional._;
import com.atgrand.testing.bdd.base.Specifications;

public class WildcardToFunctionTest extends Specifications {

    [Test]
    public function should_convert_function_to_function():void {
        it(fun(_.not)).should.be.kind.of(Function);
    }

    [Test]
    public function should_convert_composite_wildcard_to_function():void {
        it(fun(_..not)).should.be.kind.of(Function);
    }


}
}
