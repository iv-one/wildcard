package com.atgrand.functional.collections {
import com.atgrand.functional._;
import com.atgrand.functional.closure;
import com.atgrand.functional.error.NoSuchElementError;
import com.atgrand.functional.option.none;
import com.atgrand.functional.test.assertThrows;
import com.atgrand.functional.identity;
import com.atgrand.functional.test.mapFalse;
import com.atgrand.functional.test.mapTrue;

import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNull;
import org.flexunit.asserts.assertStrictlyEquals;
import org.flexunit.asserts.assertTrue;
import org.flexunit.asserts.fail;

public class NilTest {

    [Test]
    public function testContains():void {
        assertFalse(nil.contains(undefined))
    }

    [Test]
    public function testCount():void {
        nil.count(function ():Boolean {
            fail("Count function must not be called.");
            return true
        })
    }

    [Test]
    public function testNotEmpty():void {
        assertFalse(nil.nonEmpty)
    }

    [Test]
    public function testDrop():void {
        assertStrictlyEquals(nil, nil.drop(0));
        assertThrows(closure(nil.drop, -1), ArgumentError)
    }

    [Test]
    public function testDropRight():void {
        assertStrictlyEquals(nil, nil.dropRight(0));
        assertThrows(closure(nil.dropRight, -1), ArgumentError)
    }

    [Test]
    public function testDropWhile():void {
        assertStrictlyEquals(nil, nil.dropWhile(mapTrue));
        nil.dropWhile(function (x:*):Boolean {
            fail("DropWhile function must not be called.");
            return true
        })
    }

    [Test]
    public function testExists():void {
        assertFalse(nil, nil.exists(mapTrue));
        nil.exists(function (x:*):Boolean {
            fail("Exists function must not be called.");
            return true
        })
    }

    [Test]
    public function testFilter():void {
        assertStrictlyEquals(nil, nil.filter(mapTrue));
        nil.filter(function (x:*):Boolean {
            fail("Filter function must not be called.");
            return true
        })
    }

    [Test]
    public function testFilterNot():void {
        assertStrictlyEquals(nil, nil.filter(mapFalse));
        nil.filterNot(function (x:*):Boolean {
            fail("FilterNot function must not be called.");
            return true
        })
    }

    [Test]
    public function testFind():void {
        assertStrictlyEquals(null, nil.find(mapTrue));
        nil.find(function (x:*):Boolean {
            fail("Find function must not be called.");
            return true
        })
    }

    [Test]
    public function testFindIndexOf():void {
        assertEquals(-1, nil.findIndexOf(mapTrue));
        nil.findIndexOf(function (x:*):Boolean {
            fail("FindIndexOf function must not be called.");
            return true
        })
    }

    [Test]
    public function testFlatMap():void {
        assertStrictlyEquals(nil, nil.flatMap(identity));
        nil.flatMap(function (x:*):IFuncList {
            fail("FlatMap function must not be called.");
            return nil
        })
    }

    [Test]
    public function testFlatten():void {
        assertStrictlyEquals(nil, nil.flatten)
    }

    [Test]
    public function testFoldLeft():void {
        assertEquals(0, nil.foldLeft(0, _.plus_));
        nil.foldLeft(0, function (x:int, y:int):int {
            fail("FoldLeft function must not be called.");
            return x + y
        })
    }

    [Test]
    public function testFoldRight():void {
        assertEquals(0, nil.foldRight(0, _.plus_));
        nil.foldRight(0, function (x:int, y:int):int {
            fail("FoldRight function must not be called.");
            return x + y
        })
    }

    [Test]
    public function testForAll():void {
        assertFalse(nil.forall(mapTrue));
        nil.forall(function (x:*):Boolean {
            fail("Forall function must not be called.");
            return true
        })
    }

    [Test]
    public function testForeach():void {
        nil.foreach(function (x:*):void {
            fail("Foreach function must not be called.")
        })
    }

    [Test]
    public function testGet():void {
        assertThrows(closure(nil.get, 0), RangeError)
    }

    [Test]
    public function testHead():void {
        assertThrows(function ():* {
            return nil.head
        }, NoSuchElementError)
    }

    [Test]
    public function testHeadOption():void {
        assertStrictlyEquals(none, nil.headOption)
    }

    [Test]
    public function testIndexOf():void {
        assertEquals(-1, nil.indexOf(undefined))
    }

    [Test]
    public function testIndices():void {
        assertStrictlyEquals(nil, nil.indices)
    }

    [Test]
    public function testInit():void {
        assertStrictlyEquals(nil, nil.init)
    }

    [Test]
    public function testIsEmpty():void {
        assertTrue(nil.isEmpty)
    }

    [Test]
    public function testLast():void {
        assertThrows(function ():* {
            return nil.head
        }, NoSuchElementError)
    }

    [Test]
    public function testMap():void {
        assertStrictlyEquals(nil, nil.map(mapTrue));
        nil.map(function (x:*):Boolean {
            fail("Map function must not be called.");
            return true
        })
    }

    [Test]
    public function testPartition():void {
        assertStrictlyEquals(nil, nil.partition(mapTrue)._1);
        assertStrictlyEquals(nil, nil.partition(mapTrue)._2);
        nil.partition(function (x:*):Boolean {
            fail("Partition function must not be called.");
            return true
        })
    }

    [Test]
    public function testPrepend():void {
        const value:Object = {};
        assertEquals(1, nil.prepend(value).size);
        assertStrictlyEquals(value, nil.prepend(value).get(0))
    }

    [Test]
    public function testPrependAll():void {
        const l:IFuncList = list({}, {}, {});
        assertEquals(l.size, nil.prependAll(l).size);
        for (var i:int = 0, n:int = l.size; i < n; ++i) {
            assertStrictlyEquals(l.get(i), nil.prependAll(l).get(i))
        }
        assertEquals(0, nil.prependAll(nil).size);
        assertStrictlyEquals(nil, nil.prependAll(nil))
    }

    [Test]
    public function testReduceLeft():void {
        assertNull(nil.reduceLeft(_.plus_))
    }

    [Test]
    public function testReduceRight():void {
        assertNull(nil.reduceLeft(_.plus_))
    }

    [Test]
    public function testReverse():void {
        assertStrictlyEquals(nil, nil.reverse)
    }

    [Test]
    public function testTail():void {
        assertThrows(function ():* {
            return nil.tail
        }, NoSuchElementError)
    }

    [Test]
    public function testTailOption():void {
        assertStrictlyEquals(none, nil.tailOption)
    }

    [Test]
    public function testTake():void {
        assertStrictlyEquals(nil, nil.take(0));
        assertThrows(closure(nil.take, -1), ArgumentError)
    }

    [Test]
    public function testTakeRight():void {
        assertStrictlyEquals(nil, nil.takeRight(0));
        assertThrows(closure(nil.takeRight, -1), ArgumentError)
    }

    [Test]
    public function testTakeWhile():void {
        assertStrictlyEquals(nil, nil.takeWhile(mapTrue));
        nil.takeWhile(function (x:*):Boolean {
            fail("TakeWhile function must not be called.");
            return true
        })
    }

    [Test]
    public function testZip():void {
        assertStrictlyEquals(nil, nil.zip(Range.until(0, 10)))
    }

    [Test]
    public function testZipWithIndex():void {
        assertStrictlyEquals(nil, nil.zipWithIndex)
    }

    [Test]
    public function testProductArity():void {
        assertEquals(0, nil.productArity)
    }

    [Test]
    public function testProductElement():void {
        assertThrows(closure(nil.productElement, 0), RangeError)
    }

    [Test]
    public function testProductPrefix():void {
        assertEquals("List", nil.productPrefix)
    }

    [Test]
    public function testMkString():void {
        assertEquals("", nil.mkString("."))
    }

    [Test]
    public function testEquals():void {
        assertTrue(nil.equals(list(undefined)));
        assertTrue(nil.equals(list(null)));
        assertFalse(nil.equals(list({})));
        assertTrue(nil.equals(nil));
        assertTrue(nil.equals(list(1).tail))
    }

    [Test]
    public function testSize():void {
        assertEquals(0, nil.size)
    }

    [Test]
    public function testHasDefinedSize():void {
        assertTrue(nil.hasDefinedSize)
    }

    [Test]
    public function testToArray():void {
        assertEquals(0, nil.toArray.length)
    }
}
}