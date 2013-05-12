package com.atgrand.functional.option {
import com.atgrand.functional.test.assertThrows;
import com.atgrand.functional.identity;

import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNull;
import org.flexunit.asserts.assertStrictlyEquals;

import org.flexunit.asserts.assertTrue;

public final class SomeTest {
    [Test]
    public function testIsDefined():void {
        assertTrue(some({}).isDefined)
    }

    [Test]
    public function testIsEmpty():void {
        assertFalse(some({}).isEmpty)
    }

    [Test]
    public function testGet():void {
        const value:Object = {};

        assertStrictlyEquals(value, some(value).get);
        assertNull(some(undefined).get)
    }

    [Test]
    public function testGetOrElse():void {
        const value:Object = {};

        assertStrictlyEquals(value, some(value).getOrElse(function ():Object {
            throw new Error()
        }))
    }

    [Test]
    public function testFilter():void {
        const value:Object = {};
        const someTrue:IOption = some(value).filter(function (x:Object):Boolean {
            assertStrictlyEquals(value, x);
            return x === value
        });
        const someFalse:IOption = some(value).filter(function (x:Object):Boolean {
            assertStrictlyEquals(value, x);
            return x !== value
        });

        assertStrictlyEquals(value, someTrue.get);
        assertStrictlyEquals(none, someFalse)
    }

    [Test]
    public function testForeach():void {
        const value:Object = {};
        var n:int = 0;

        some(value).foreach(function (x:Object):void {
            assertStrictlyEquals(value, x);
            n += 1
        });

        assertEquals(1, n)
    }

    [Test]
    public function testFlatMap():void {
        const value:Object = {};

        assertStrictlyEquals(value, some(value).flatMap(
                function (x:Object):IOption {
                    assertStrictlyEquals(value, x);
                    return some(value)
                }).get);

        assertThrows(function ():void {
            some(value).flatMap(identity)
        }, TypeError)
    }

    [Test]
    public function testMap():void {
        const value:int = 1234;
        const f:Function = function (x:int):String {
            return x.toString()
        };

        assertEquals(f(value), some(value).map(f).get);
        assertTrue(some(f(value)).equals(some(value).map(f)))
    }

    [Test]
    public function testOrElse():void {
        const option:IOption = some(true);
        const alternative:Function = function ():IOption {
            return some(false)
        };

        assertTrue(option.orElse(alternative).get);
        assertStrictlyEquals(option, option.orElse(alternative))
    }

    [Test]
    public function testProductArity():void {
        assertEquals(1, some({}).productArity)
    }

    [Test]
    public function testProductElement():void {
        const value:Object = {};

        assertStrictlyEquals(value, some(value).productElement(0));
        assertThrows(function ():void {
            some(value).productElement(1)
        }, RangeError)
    }

    [Test]
    public function testProductPrefix():void {
        assertEquals("Some", some({}).productPrefix)
    }

    [Test]
    public function testToString():void {
        assertEquals("Some(null)", some(null).toString());
        assertEquals("Some(1)", some(1).toString());
        assertEquals("Some(1)", some("1").toString());
        assertEquals("Some(undefined)", some(undefined).toString())
    }

    [Test]
    public function testEquals():void {
        assertTrue(some(1).equals(some(1)));
        assertEquals(Object(1) == Object("1"), some(1).equals(some("1")));
        assertTrue(some(null).equals(some(null)));
        assertTrue(some(undefined).equals(some(undefined)));
        assertFalse(some({}).equals(some({})));
        assertTrue(some(some(1)).equals(some(some(1))))
    }
}
}