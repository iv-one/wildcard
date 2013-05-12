package com.atgrand.functional.option {
import com.atgrand.functional.closure
import com.atgrand.functional.error.NoSuchElementError;
import com.atgrand.functional.test.assertThrows;

import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertStrictlyEquals;
import org.flexunit.asserts.assertTrue;
import org.flexunit.asserts.fail;

public final class NoneTest {
    [Test]
    public function testIsDefined():void {
        assertFalse(none.isDefined)
    }

    [Test]
    public function testIsEmpty():void {
        assertTrue(none.isEmpty)
    }

    [Test]
    public function testGet():void {
        assertThrows(function ():void { none.get }, NoSuchElementError)
    }

    [Test]
    public function testGetOrElse():void {
        const value:Object = {};
        assertStrictlyEquals(value, none.getOrElse(function ():Object { return value }))
    }

    [Test]
    public function testFilter():void {
        assertStrictlyEquals(none,
                             none.filter(
                                     function (x:*):Boolean {
                                         fail("Filter function must not be called.");
                                         return true
                                     }
                             )
        )
    }

    [Test]
    public function testForeach():void {
        none.foreach(function (x:*):void { fail("Foreach function must not be called.") })
    }

    [Test]
    public function testFlatMap():void {
        assertStrictlyEquals(none,
                             none.flatMap(
                                     function (x:*):IOption {
                                         fail("FlatMap function must not be called.");
                                         return some({})
                                     }
                             )
        )
    }

    [Test]
    public function testMap():void {
        assertStrictlyEquals(none,
                             none.map(
                                     function (x:*):* {
                                         fail("Map function must not be called.");
                                         return some({})
                                     }
                             )
        )
    }

    [Test]
    public function testOrElse():void {
        const alternative:Function = function ():IOption { return some(false) };

        assertFalse(none.orElse(alternative).get);
        assertTrue(alternative().equals(none.orElse(alternative)))
    }

    [Test]
    public function testProductArity():void {
        assertEquals(0, none.productArity)
    }

    [Test]
    public function testProductElement():void {
        assertThrows(closure(none.productElement, 0), RangeError)
    }

    [Test]
    public function testProductPrefix():void {
        assertEquals("None", none.productPrefix)
    }

    [Test]
    public function testToString():void {
        assertEquals("None", none.toString())
    }

    [Test]
    public function testEquals():void {
        assertTrue(none.equals(none));
        assertFalse(some(null).equals(none));
        assertFalse(some(undefined).equals(none))
    }
}
}