package com.atgrand.functional {

import com.atgrand.functional.compose;
import com.atgrand.testing.bdd.base.Specifications;

public class ComposeTest extends Specifications {
    [Test]
    public function should_compose_two_function():void {
        var f:Function = function (x:int):int {return x * x};
        var g:Function = function (x:int):int {return x + x};
        var c:Function = compose(f, g);
        it(c(3)).should.equal((3 + 3) * (3 + 3));

        c = compose(g, f);
        it(c(3)).should.equal((3 * 3) + (3 * 3));
    }

    [Test]
    public function should_return_original_function_if_one_of_function_is_null():void {
        var f:Function = function (x:int):int {return x * x};
        var c:Function = compose(f, null);
        it(c(3)).should.equal(f(3));

        c = compose(null, f);
        it(c(4)).should.equal(f(4));
    }
}
}