package com.atgrand.functional.collections.immutable {

import com.atgrand.functional._;
import com.atgrand.functional.collections.IFuncList;
import com.atgrand.functional.collections.list;
import com.atgrand.testing.bdd.base.Specifications;

public class CompositeWildcardListTest extends Specifications {

    private var _list:IFuncList;

    [Before]
    public function setUp():void {
        _list = list(1, 2, 3, 4, 5).map(_.produce(Mock));
    }

    [Test]
    public function should_support_count():void {
        it(_list.count(_..index.isOdd)).should.equal(3);
        it(_list.count(_..index.isEven)).should.equal(2);
    }

    [Test]
    public function should_support_exists():void {
        it(_list.exists(_..index.equals(3))).should.be._true();
        it(_list.exists(_..index.equals(10))).should.be._false();
    }

    [Test]
    public function should_support_find():void {
        it(_list.find(_..index.equals(3))).should.have.properties({name:"mock-3"});
        it(_list.find(_..index.equals(12))).should.be.nil();
        it(_list.find(_..object.index.equals(10))).should.have.properties({name:"mock-5"});
    }
}
}

class Mock {
    public var name:String;

    public var index:int;

    public var object:Object;

    public function Mock(index:int) {
        this.index = index;
        this.name = "mock-" + index;
        object = {index:index * 2};
    }

    public function echo(string:String):String {
        return string + "-" + index;
    }
}