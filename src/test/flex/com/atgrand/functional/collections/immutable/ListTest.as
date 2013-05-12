package com.atgrand.functional.collections.immutable {
import com.atgrand.functional._;
import com.atgrand.functional.closure;
import com.atgrand.functional.collections.IFuncList;
import com.atgrand.functional.collections.Range;
import com.atgrand.functional.collections.list;
import com.atgrand.functional.collections.nil;
import com.atgrand.functional.collections.toList;
import com.atgrand.functional.option.none;
import com.atgrand.functional.option.some;
import com.atgrand.functional.test.assertThrows;
import com.atgrand.functional.identity;
import com.atgrand.functional.test.mapFalse;
import com.atgrand.functional.test.mapTrue;
import com.atgrand.functional.tuple.ITuple2;
import com.atgrand.functional.tuple.tuple2;
import com.atgrand.testing.bdd.base.Specifications;

import org.flexunit.assertThat;

import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;
import org.flexunit.asserts.assertStrictlyEquals;

import org.flexunit.asserts.assertTrue;
import org.hamcrest.collection.array;
import org.hamcrest.object.hasProperties;

public class ListTest extends Specifications {
    [Test]
    public function testContains():void {
        assertTrue(Range.to(1, 10).map(closure(some)).contains(some(2)));
        assertFalse(Range.to(1, 10).map(closure(some)).contains(some(0)));
        assertFalse(Range.to(1, 10).map(closure(some)).contains(none))
    }

    [Test]
    public function testCount():void {
        assertEquals(5, list(1, 2, 3, 4, 5, 6, 7, 8, 9, 10).count(_.isEven));
        assertEquals(5, Range.to(1, 10).count(_.isEven));
        assertEquals(0, Range.to(1, 10).count(_.greaterThan(10)));
        assertEquals(1, Range.to(1, 10).count(_.equals(10)))
    }

    [Test]
    public function testNotEmpty():void {
        assertTrue(list(1).nonEmpty);
        assertTrue(list(1, 2).nonEmpty);
        assertFalse(list().nonEmpty)
    }

    [Test]
    public function testDrop():void {
        assertThrows(closure(list(1, 2).drop, -1), ArgumentError);
        assertEquals(2, list(1, 1, 2).drop(2).head);
        assertStrictlyEquals(nil, list(1, 2).drop(2));
        assertTrue(list(3, 4).equals(list(1, 2, 3, 4).drop(2)));
        const l:IFuncList = list(1, 2, 3);
        assertStrictlyEquals(l, l.drop(0))
    }

    [Test]
    public function testDropRight():void {
        assertThrows(closure(list(1, 2).dropRight, -1), ArgumentError);
        assertEquals(1, list(1, 2, 2).dropRight(2).head);
        assertStrictlyEquals(nil, list(1, 2).dropRight(2));
        assertTrue(list(1, 2).equals(list(1, 2, 3, 4).dropRight(2)));
        const l:IFuncList = list(1, 2, 3);
        assertStrictlyEquals(l, l.dropRight(0))
    }

    [Test]
    public function testDropWhile():void {
        assertStrictlyEquals(nil, list(1, 2, 3, 4).dropWhile(mapTrue));
        const l:IFuncList = list(1, 2, 3);
        assertStrictlyEquals(l, l.dropWhile(mapFalse))
    }

    [Test]
    public function testExists():void {
        assertTrue(list(1).exists(mapTrue));
        assertTrue(Range.to(1, 10).exists(_.equals(5)));
        assertFalse(Range.to(1, 10).exists(_.equals(0)))
    }

    [Test]
    public function testFilter():void {
        const l:IFuncList = list(1, 2, 3);
        assertStrictlyEquals(l, l.filter(mapTrue));
        assertTrue(list(2, 4, 6, 8, 10).equals(Range.to(1, 10).filter(_.isEven)))
    }

    [Test]
    public function testFilterNot():void {
        const l:IFuncList = list(1, some(2), 1, some(2));
        assertEquals(l.size - 2, l.filterNot(_.equals(some(2))).size);
        assertEquals(l.size, l.filterNot(mapFalse).size);
        assertStrictlyEquals(nil, l.filterNot(mapTrue))
    }

    [Test]
    public function testFind():void {
        assertStrictlyEquals(null, Range.to(1, 10).map(closure(some)).find(_.equals(none)))
    }

    [Test]
    public function testFindIndexOf():void {
        assertEquals(2, list(0, 1, 2).findIndexOf(_.equals(2)));
        assertEquals(-1, list(0, 1, 2).findIndexOf(_.equals(3)))
    }

    [Test]
    public function testFlatMap():void {
        assertTrue(list("a", "b", "c", "d").equals(list("a", "b", "c", "d").flatMap(toList)));
        assertTrue(list(1, 3).equals(list(1, 2, 3).flatMap(function (x:int):IFuncList {
            return x == 2 ? nil : list(x)
        })));

        assertThrows(function ():void {
            list(1, 2, 3).flatMap(function ():Object {
                return {}
            })
        }, TypeError)
    }

    [Test]
    public function testFlatten():void {
        assertTrue(list(1, 2, 3), list(list(1), nil, list(2), nil, nil, list(3)).flatten)
    }

    [Test]
    public function testFoldLeft():void {
        const n:int = 100;
        assertEquals(n * (n + 1) / 2, Range.to(1, n).foldLeft(0, _.plus_));
        assertEquals((n + 1) * ((n + 1) + 1) / 2, Range.to(1, n + 1).foldLeft(0, _.plus_));
        assertEquals("#" + "TEST".toLowerCase(), toList("TEST").map(_.toLowerCase).foldLeft("#", _.plus_))
    }

    [Test]
    public function testFoldRight():void {
        const n:int = 100;
        assertEquals(n * (n + 1) / 2, Range.to(1, n).foldRight(0, _.plus_));
        assertEquals((n + 1) * ((n + 1) + 1) / 2, Range.to(1, n + 1).foldRight(0, _.plus_));
        assertEquals("#" + "test".toUpperCase(), toList("tset").map(_.toUpperCase).foldRight("#", _.plus_));
    }

    [Test]
    public function testForall():void {
        assertTrue(Range.to(1, 10).forall(mapTrue));
        assertFalse(Range.to(1, 10).forall(mapFalse));
        assertTrue(Range.to(1, 10).forall(_.lessThan(11)));
        assertFalse(Range.to(1, 10).forall(_.lessThan(10)))
    }

    [Test]
    public function testForeach():void {
        const n:int = 10;
        var i:int = 0;

        Range.until(0, n).foreach(function (x:int):void {
            assertEquals(i++, x)
        });

        assertEquals(i, n)
    }

    [Test]
    public function testGet():void {
        assertTrue(Range.until(0, 10).equals(Range.until(0, 10)));

        Range.until(0, 10).zipWithIndex.foreach(function (x:ITuple2):void {
            assertEquals(x._1, Range.until(0, 10).get(x._2))
        });

        assertThrows(closure(Range.until(0, 10).get, -1), RangeError);
        assertThrows(closure(Range.until(0, 10).get, 10), RangeError)
    }

    [Test]
    public function testHead():void {
        const value:Object = {};
        assertStrictlyEquals(value, list(value, 2, 3).head);
        assertEquals(1, list(1, 2, 3).head);
        assertNull(list(undefined, 2, 3).head)
    }

    [Test]
    public function testHeadOption():void {
        const value:Object = {};
        assertStrictlyEquals(value, list(value, 2, 3).headOption.get);
        assertEquals(1, list(1, 2, 3).headOption.get);
        assertNull(list(undefined, 2, 3).headOption.get)
    }

    [Test]
    public function testIndexOf():void {
        assertEquals(0, Range.to(0, 10).indexOf(0));
        assertEquals(9, Range.to(0, 10).indexOf(9));
        assertEquals(4, Range.to(0, 10).indexOf(4));
        assertEquals(-1, Range.to(0, 10).indexOf(11))
    }

    [Test]
    public function testIndices():void {
        const value:String = "test";
        assertTrue(Range.until(0, value.length).equals(toList(value).indices))
    }

    [Test]
    public function testInit():void {
        const l:IFuncList = list(1, 2, 3);
        assertEquals(l.size - 1, l.init.size);
        assertEquals("tes", toList("test").init.reduceLeft(_.plus_))
    }

    [Test]
    public function testIsEmpty():void {
        assertTrue(list().isEmpty);
        assertTrue(list(undefined).isEmpty)
    }

    [Test]
    public function testLast():void {
        assertEquals("$", toList("test$").last)
    }

    [Test]
    public function testMap():void {
        const l:IFuncList = list(2, 4, 6, 8);
        assertEquals(l.reduceLeft(_.plus_) / 2, l.map(_.divideBy(2)).reduceLeft(_.plus_))
    }

    [Test]
    public function testPartition():void {
        const l:IFuncList = Range.to(1, 10);
        const p:ITuple2 = l.partition(_.isEven);
        assertTrue(p._1 is IFuncList);
        assertTrue(p._2 is IFuncList);
        assertEquals(5, p._1.size);
        assertEquals(5, p._2.size);
        assertTrue(l.filter(_.isEven).equals(p._1));
        assertTrue(l.filterNot(_.isEven).equals(p._2))
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
        const n:int = 100;
        assertEquals(n * (n + 1) / 2, Range.to(1, n).reduceLeft(_.plus_));
        assertEquals((n + 1) * ((n + 1) + 1) / 2, Range.to(1, n + 1).reduceLeft(_.plus_));
        assertEquals("TEST".toLowerCase(), toList("TEST").map(_.toLowerCase).reduceLeft(_.plus_))
    }

    [Test]
    public function testReduceRight():void {
        const n:int = 100;
        assertEquals(n * (n + 1) / 2, Range.to(1, n).reduceRight(_.plus_));
        assertEquals((n + 1) * ((n + 1) + 1) / 2, Range.to(1, n + 1).reduceRight(_.plus_));
        assertEquals("test".toUpperCase(), toList("tset").map(_.toUpperCase).reduceRight(_.plus_));
    }

    [Test]
    public function testReverse():void {
        assertTrue(toList("ogeniederherrehredeinego").equals(toList("ogeniederherrehredeinego").reverse));
        assertTrue(list(5, 4, 3, 2, 1).equals(list(1, 2, 3, 4, 5).reverse))
    }

    [Test]
    public function testTail():void {
        assertTrue(list(1).tail.isEmpty);
        assertFalse(list(1, 2).tail.isEmpty);
        assertTrue(list(2).equals(list(1, 2).tail))
    }

    [Test]
    public function testTailOption():void {
        assertTrue(com.atgrand.functional.option.some(nil), list(1).tailOption);
        assertTrue(com.atgrand.functional.option.some(list(2)).equals(list(1, 2).tailOption))
    }

    [Test]
    public function testTake():void {
        assertThrows(closure(list(1).take, -1), ArgumentError);
        assertTrue(list(true).take(1).head);
        assertTrue(list(true, false).equals(list(true, false, false, false).take(2)))
    }

    [Test]
    public function testTakeRight():void {
        assertThrows(closure(list(1).takeRight, -1), ArgumentError);
        assertTrue(list(true).takeRight(1).head);
        assertTrue(list(true, false).equals(list(false, false, true, false).takeRight(2)))
    }

    [Test]
    public function testTakeWhile():void {
        assertTrue(list(true, true, true).equals(list(true, true, true).takeWhile(mapTrue)));
        assertTrue(nil.equals(list(true, true, true).takeWhile(mapFalse)))
    }

    [Test]
    public function testZip():void {
        assertTrue(list(tuple2(1, 1), tuple2(2, 2), tuple2(3, 3)).equals(Range.to(1, 3).zip(Range.to(1, 3))));

        assertTrue(list(tuple2(1, 1), tuple2(2, 2), tuple2(3, 3)).equals(Range.to(1, 4).zip(Range.to(1, 3))));

        assertTrue(list(tuple2(1, 1), tuple2(2, 2), tuple2(3, 3)).equals(Range.to(1, 3).zip(Range.to(1, 4))))
    }

    [Test]
    public function testZipWithIndex():void {
        assertTrue(list(tuple2(1, 0), tuple2(2, 1), tuple2(3, 2)).equals(Range.to(1, 3).zipWithIndex))
    }

    [Test]
    public function testProductArity():void {
        const n:int = 10;
        assertEquals(Range.to(1, n).size, Range.to(1, n).productArity);
        assertEquals(Range.to(1, n + 1).size, Range.to(1, n + 1).productArity)
    }

    [Test]
    public function testProductElement():void {
        const value:Object = {};
        assertThrows(closure(list(0).productElement, 1), RangeError);
        assertThrows(closure(list(0).productElement, -1), RangeError);
        assertStrictlyEquals(value, list(value).productElement(0))
    }

    [Test]
    public function testProductPrefix():void {
        assertEquals("List", list(0).productPrefix)
    }

    [Test]
    public function testMkString():void {
        assertEquals("1, 2, 3", list(1, 2, 3).mkString(", "))
    }

    [Test]
    public function testEquals():void {
        assertTrue(list(undefined).equals(list(undefined)));
        assertTrue(list(null).equals(list(null)));
        assertFalse(list({}).equals(list({})));
        assertTrue(list().equals(list()));
        assertTrue(list().equals(list(1).tail))
    }

    [Test]
    public function testSize():void {
        const n:int = 10;
        assertEquals(0, list().size);
        assertEquals(n, Range.to(1, n).size);
        assertEquals(n + 1, Range.to(1, n + 1).size)
    }

    [Test]
    public function testHasDefinedSize():void {
        assertTrue(list().hasDefinedSize);
        assertTrue(list(1).hasDefinedSize)
    }

    [Test]
    public function testToArray():void {
        const n:int = 10;
        assertEquals(0, list().toArray.length);
        assertEquals(n, Range.to(1, n).toArray.length);
        assertEquals(n + 1, Range.to(1, n + 1).toArray.length);
        assertEquals(1, list(1, 2, 3).toArray[0]);
        assertEquals(2, list(1, 2, 3).toArray[1]);
        assertEquals(3, list(1, 2, 3).toArray[2])
    }

    [Test]
    public function testAppend():void {
        const l:IFuncList = list(1);
        assertTrue(list(1, 2, 3).equals(list(1, 2).append(3)));
        assertTrue(l.size < l.append(null).size);
        assertTrue(list(1, 2, nil).equals(list(1, 2).append(nil)))
    }

    [Test]
    public function testAppendAll():void {
        const l0:IFuncList = list(1, 2, 3);
        const l1:IFuncList = list(4, 5, 6);

        assertTrue(list(1, 2, 3, 4, 5, 6).equals(l0.appendAll(l1)));
        assertTrue(l0.equals(l0.appendAll(nil)))
    }

    [Test]
    public function testIterator():void {
        assertNotNull(list(1).iterator);
        assertTrue(list(1).iterator.hasNext);
        assertEquals(1, list(1).iterator.next())
    }

    [Test]
    public function testAppendIterable():void {
        const l0:IFuncList = list(1, 2, 3);
        const l1:IFuncList = list(4, 5, 6);

        assertTrue(list(1, 2, 3, 4, 5, 6).equals(l0.appendIterable(l1)));
        assertTrue(l0.equals(l0.appendIterable(nil)))
    }

    [Test]
    public function testAppendIterator():void {
        const l0:IFuncList = list(1, 2, 3);
        const l1:IFuncList = list(4, 5, 6);

        assertTrue(list(1, 2, 3, 4, 5, 6).equals(l0.appendIterator(l1.iterator)));
        assertTrue(l0.equals(l0.appendIterator(nil.iterator)))
    }

    [Test]
    public function testPrependIterable():void {
        const l0:IFuncList = list(1, 2, 3);
        const l1:IFuncList = list(4, 5, 6);

        assertTrue(list(4, 5, 6, 1, 2, 3).equals(l0.prependIterable(l1)));
        assertTrue(l0.equals(l0.prependIterable(nil)))
    }

    [Test]
    public function testPrependIterator():void {
        const l0:IFuncList = list(1, 2, 3);
        const l1:IFuncList = list(4, 5, 6);

        assertTrue(list(4, 5, 6, 1, 2, 3).equals(l0.prependIterator(l1.iterator)));
        assertTrue(l0.equals(l0.prependIterator(nil.iterator)))
    }

    [Test]
    public function testUniq():void {
        var actual:Array = list(1, 2, 3, 3, 2, 1, 1).uniq(identity).array;
        it(actual).should.equal([1, 2, 3]);
    }

    [Test]
    public function testUniqByProperty():void {
        var actual:Array = list(1, 2, 3, 3, 2, 1, 1).map(function(x:*):*{return {id:x}}).uniq(_.id).array;
        it(actual).should.be.array.like([hasProperties({id:1}), hasProperties({id:2}), hasProperties({id:3})]);
    }
}
}