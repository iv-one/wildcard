/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 23.07.12
 * Time: 16:27
 */
package com.atgrand.functional {

import com.atgrand.functional.wildcard.fun;
import com.atgrand.testing.bdd.base.Specifications;

public class CompositeWildcardTest extends Specifications {

    private var mock:Mock = new Mock();

    [Test]
    public function should_create_composite_wildcard():void {
        it(_..property).should.be.kind.of(CompositeWildcard);
        it(fun(_..property)({property:something})).should.be.same_as(something);
    }

    [Test]
    public function should_delegate_callProperty_to_wildcard():void {
        it(fun(_..property.echo("test"))({property:mock})).should.equal("test");
    }

    [Test]
    public function should_use_wildcard_functions_if_possible():void {
        it(fun(_..name.equals("mock"))(mock)).should.be._true();
        it(fun(_..name.equals("mock2"))(mock)).should.be._false();
    }

    [Test]
    public function should_use_constants_of_wildcard_functions_if_possible():void {
        it(fun(_..ok.not)(mock)).should.be._true();
    }

    [Test]
    public function should_apply_chain_of_properties():void {
        mock.level2 = new Mock();
        it(fun(_..level2.name)(mock)).should.be._true();
    }

    [Test]
    public function should_apply_any_level_of_calls():void {
        mock.level2 = new Mock();
        it(fun(_..level2.name.equals("mock"))(mock)).should.be._true();
        it(fun(_..level2.ok.not)(mock)).should.be._true();
    }
}
}

class Mock {
    public var ok:Boolean = false;

    public var name:String = "mock";

    public var level2:Mock;

    public function echo(string:String):String {
        return string;
    }
}
