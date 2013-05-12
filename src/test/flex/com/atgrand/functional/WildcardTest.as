/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 08.11.11
 * Time: 16:37
 */
package com.atgrand.functional {

import com.atgrand.functional.IActivableObject;
import com.atgrand.functional.collections.Range;
import com.atgrand.functional.collections.list;
import com.atgrand.testing.bdd.base.Specifications;

import mx.utils.ObjectProxy;

import org.flexunit.assertThat;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNull;
import org.flexunit.asserts.assertTrue;
import org.hamcrest.object.instanceOf;

public class WildcardTest extends Specifications {
    [Test]
    public function should_return_curry_on_get_property():void {
        var object:Object = {name:"name"};
        it((_.name)(object)).should.equal("name");
    }

    [Test]
    public function provide_not_in_array_curry():void {
        it(_.notIn([3, 4, 5])(2)).should.be._true();
        it(_.notIn([2, 3, 4])(2)).should.be._false();
    }

    [Test]
    public function testBinaryNot():void {
        assertEquals(~1234, _.binaryNot(1234))
    }

    [Test]
    public function testDecrementBy():void {
        assertEquals(1, _.decrementBy(1)(2));
        assertEquals(0, _.decrementBy(2)(2));
        assertEquals(-1, _.decrementBy(3)(2));
        assertEquals(3, _.decrementBy(-1)(2))
    }

    [Test]
    public function testDivideBy():void {
        const n:int = 10;
        Range.until(1, n).foreach(function (i:int):void {
            assertEquals(1, _.divideBy(i)(i))
        });

        Range.until(1, n + 1).foreach(function (i:int):void {
            assertEquals(1, _.divideBy(i)(i))
        });

        assertEquals(-1, _.divideBy(-3)(3));
        assertEquals(2.5, _.divideBy(2)(5))
    }

    [Test]
    public function testEquals():void {
        const a:int = 1;
        const b:int = 1;
        assertFalse(_.equals({})({}));
        assertTrue(_.equals(a)(b));
        assertTrue(_.equals(b)(a));
        assertTrue(_.equals(some(a))(some(b)));
        assertTrue(_.equals(some(b))(some(a)))
    }

    [Test]
    public function testGet():void {
        const a:Object = { property:1 };
        assertEquals(1, _.get("property")(a));
        assertNull(_.get("unknown")(a))
    }

    [Test]
    public function testImplicitGet():void {
        const a:Object = { property:1 };
        assertEquals(1, (_.property)(a));
        assertNull((_.unknown)(a))
    }

    [Test]
    public function testImplicitCall():void {
        const a:Object = { callMe:function (p0:int, p1:int):int { return p0 + p1 } };
        assertEquals(3, _.callMe(1, 2)(a))
    }

    [Test]
    public function testGreaterEqual():void {
        assertTrue(_.greaterEqual(5)(6));
        assertTrue(_.greaterEqual(5)(5));
        assertFalse(_.greaterEqual(5)(4))
    }

    [Test]
    public function testGreaterThan():void {
        assertTrue(_.greaterThan(5)(6));
        assertFalse(_.greaterThan(5)(5));
        assertFalse(_.greaterThan(5)(4))
    }

    [Test]
    public function testIncrementBy():void {
        assertEquals(3, _.incrementBy(1)(2));
        assertEquals(4, _.incrementBy(2)(2));
        assertEquals(2, _.incrementBy(3)(-1));
        assertEquals(1, _.incrementBy(-1)(2))
    }

    [Test]
    public function testInRange():void {
        assertTrue(_.inRange(0, 10)(0));
        assertTrue(_.inRange(0, 10)(10));
        assertFalse(_.inRange(0, 10)(11));
        assertFalse(_.inRange(0, 10)(-1))
    }

    [Test]
    public function testIsActive():void {
        const object:IActivableObject = new SelectableActivableObject();

        assertFalse(_.isActive(object));
        object.active = true;
        assertTrue(_.isActive(object));
    }

    [Test]
    public function testIsSelected():void {
        const object:ISelectableObject = new SelectableActivableObject();

        assertFalse(_.isSelected(object));
        object.selected = true;
        assertTrue(_.isSelected(object));
    }

    [Test]
    public function testIsEven():void {
        assertTrue(_.isEven(2));
        assertFalse(_.isEven(1));
        assertTrue(list(2, 4, 6, 8, 10).equals(Range.to(1, 10).filter(_.isEven)))
    }

    [Test]
    public function testIsOdd():void {
        assertFalse(_.isOdd(2));
        assertTrue(_.isOdd(1));
        assertTrue(list(1, 3, 5, 7, 9).equals(Range.to(1, 10).filter(_.isOdd)))
    }

    [Test]
    public function testLessEqual():void {
        assertFalse(_.lessEqual(5)(6));
        assertTrue(_.lessEqual(5)(5));
        assertTrue(_.lessEqual(5)(4))
    }

    [Test]
    public function testLessThan():void {
        assertFalse(_.lessThan(5)(6));
        assertFalse(_.lessThan(5)(5));
        assertTrue(_.lessThan(5)(4))
    }

    [Test]
    public function testModuloBy():void {
        assertEquals(1, _.moduloBy(4)(5));
        assertEquals(0, _.moduloBy(4)(4))
    }

    [Test]
    public function testMultiplyBy():void {
        assertEquals(5, _.multiplyBy(1)(5));
        assertEquals(8, _.multiplyBy(2)(4));
        assertEquals(2, _.multiplyBy(0.5)(4))
    }

    [Test]
    public function testNot():void {
        assertFalse(_.not(true));
        assertTrue(_.not(false))
    }

    [Test]
    public function testNotEquals():void {
        const a:int = 1;
        const b:int = 1;
        assertTrue(_.notEquals({})({}));
        assertFalse(_.notEquals(a)(b));
        assertFalse(_.notEquals(b)(a));
        assertFalse(_.notEquals(some(a))(some(b)));
        assertFalse(_.notEquals(some(b))(some(a)))
    }

    [Test]
    public function testToBoolean():void {
        assertTrue(_.toBoolean(true));
        assertFalse(_.toBoolean(false));
        assertTrue(_.toBoolean(1));
        assertFalse(_.toBoolean(0));
        assertTrue(_.toBoolean("."));
        assertFalse(_.toBoolean(null));
        assertTrue(_.toBoolean({}))
    }

    [Test]
    public function testToLowerCase():void {
        assertEquals("null", _.toLowerCase(null));
        assertEquals("undefined", _.toLowerCase(undefined));
        assertEquals("test", _.toLowerCase("TEST"))
    }

    [Test]
    public function testToString():void {
        assertEquals("null", _.toString(null));
        assertEquals("undefined", _.toString(undefined));
        assertEquals("test", _.toString("test"))
    }

    [Test]
    public function testToUpperCase():void {
        assertEquals("NULL", _.toUpperCase(null));
        assertEquals("UNDEFINED", _.toUpperCase(undefined));
        assertEquals("TEST", _.toUpperCase("test"))
    }

    [Test]
    public function testPlus_():void {
        assertEquals(5050, Range.to(1, 100).reduceLeft(_.plus_))
    }

    [Test]
    public function testMinus_():void {
        assertEquals(-5048, Range.to(1, 100).reduceLeft(_.minus_))
    }

    [Test]
    public function testMultiply_():void {
        assertEquals(2 * 3 * 4 * 5, Range.to(1, 5).reduceLeft(_.multiply_))
    }

    [Test]
    public function testDivide_():void {
        assertEquals(1 / 2 / 3 / 4 / 5, Range.to(1, 5).reduceLeft(_.divide_))
    }

    [Test]
    public function testModulo_():void {
        assertEquals(1 % 2 % 3 % 4 % 5, Range.to(1, 5).reduceLeft(_.modulo_))
    }

    [Test]
    public function testLessThan_():void {
        assertTrue(_.lessThan_(1, 2));
        assertFalse(_.lessThan_(1, 1));
        assertFalse(_.lessThan_(2, 1))
    }

    [Test]
    public function testGreaterThan_():void {
        assertFalse(_.greaterThan_(1, 2));
        assertFalse(_.greaterThan_(1, 2));
        assertTrue(_.greaterThan_(2, 1))
    }

    [Test]
    public function testGreaterEqual_():void {
        assertFalse(_.greaterEqual_(1, 2));
        assertTrue(_.greaterEqual_(1, 1));
        assertTrue(_.greaterEqual_(2, 1))
    }

    [Test]
    public function testLessEqual_():void {
        assertTrue(_.lessEqual_(1, 2));
        assertTrue(_.lessEqual_(1, 1));
        assertFalse(_.lessEqual_(2, 1))
    }

    [Test]
    public function testEqual_():void {
        const a:int = 1;
        const b:int = 1;
        assertFalse(_.equal_({}, {}));
        assertTrue(_.equal_(a, b));
        assertTrue(_.equal_(b, a));
        assertTrue(_.equal_(some(a), some(b)));
        assertTrue(_.equal_(some(b), some(a)))
    }

    [Test]
    public function testNotEqual_():void {
        const a:int = 1;
        const b:int = 1;
        assertTrue(_.notEqual_({}, {}));
        assertFalse(_.notEqual_(a, b));
        assertFalse(_.notEqual_(b, a));
        assertFalse(_.notEqual_(some(a), some(b)));
        assertFalse(_.notEqual_(some(b), some(a)))
    }

    [Test]
    public function should_produce_class():void {
        assertThat(instanceOf(ObjectProxy), _.produce(ObjectProxy)({}));
    }

    [Test]
    public function should_instantiate_instance_by_class():void {
        assertThat(instanceOf(ObjectProxy), _.instantiate(ObjectProxy));
    }
}
}
import com.atgrand.functional.IActivableObject;
import com.atgrand.functional.ISelectableObject;

internal class SelectableActivableObject implements ISelectableObject, IActivableObject {

    private var _selected:Boolean;
    private var _active:Boolean;

    public function get selected():Boolean {
        return _selected;
    }

    public function set selected(value:Boolean):void {
        _selected = value;
    }

    public function get active():Boolean {
        return _active;
    }

    public function set active(value:Boolean):void {
        _active = value;
    }
}