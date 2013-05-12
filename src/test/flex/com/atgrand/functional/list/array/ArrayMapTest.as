/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 23.11.11
 * Time: 12:14
 */
package com.atgrand.functional.list.array {
import com.atgrand.testing.bdd.base.Specifications;
import com.atgrand.functional._;

public class ArrayMapTest extends Specifications {

    public var array:Array;

    [Before]
    public function init():void {
        array = [
            new MockObject(1, "name1"),
            new MockObject(2, "name2"),
            new MockObject(3, "name3")
        ]
    }

    [Test]
    public function should_support_call_property():void {
        it(array.map(_.getName())).should.be.array.like(["name1-1", "name2-2", "name3-3"]);
    }
}
}
class MockObject {
    public var index:int;
    public var name:String;

    public function MockObject(index:int, name:String) {
        this.index = index;
        this.name = name;
    }

    public function getName():String {
        return [name, index].join("-");
    }
}
