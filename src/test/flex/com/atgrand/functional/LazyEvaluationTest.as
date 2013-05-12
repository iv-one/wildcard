package com.atgrand.functional {

import com.atgrand.functional.test.assertThrows
import com.atgrand.functional.identity

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertStrictlyEquals;
import org.flexunit.asserts.assertTrue;

public class LazyEvaluationTest {
    [Test]
    public function testLazy():void {
        var n:int = 0;
        const value:ILazy = lazy(function ():Boolean {
            n++;
            return true;
        });

        assertEquals(0, n);
        assertTrue(value.get);
        assertEquals(1, n);
        assertTrue(value.get);
        assertEquals(1, n);
    }

    [Test]
    public function testClosureEvaluation():void {
        const myClass:Object = {
            expensiveComputation:function (x:int):int {
                assertEquals(1, x);
                myClass.evaluated = true;
                return 2
            },
            evaluated:false
        };

        assertFalse(myClass.evaluated);
        const l:ILazy = lazy(closure(_.expensiveComputation(1), myClass));
        assertFalse(myClass.evaluated);
        assertEquals(2, l.get);
        assertTrue(myClass.evaluated);
    }

    [Test]
    public function testProductArity():void {
        assertEquals(1, lazy(identity).productArity)
    }

    [Test]
    public function testProductElement():void {
        const value:Object = {};
        const l:ILazy = lazy(function ():Object { return value });

        assertStrictlyEquals(value, l.productElement(0));
        assertThrows(closure(l.productElement, 1), RangeError);
        assertThrows(closure(l.productElement, -1), RangeError)
    }

    [Test]
    public function testProductPrefix():void {
        assertEquals("", lazy(identity).productPrefix)
    }

    [Test]
    public function testMkString():void {
        const value:Object = {};
        assertEquals(value.toString(), lazy(
                function ():Object {return value}).get.toString())
    }

    [Test]
    public function testEquals():void {
        const value:Object = {};
        assertTrue(lazy(
                function ():Object {return value}).equals(lazy(function ():Object {return value})))
    }
}
}