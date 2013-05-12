package com.atgrand.functional.collections.immutable {
import com.atgrand.functional.IFunkObject;
import com.atgrand.functional.IImmutable;
import com.atgrand.functional.Product;
import com.atgrand.functional._;
import com.atgrand.functional.collections.IFuncIterable
import com.atgrand.functional.collections.IFuncIterator
import com.atgrand.functional.collections.IFuncList;
import com.atgrand.functional.collections.nil;
import com.atgrand.functional.collections.toList
import com.atgrand.functional.error.NoSuchElementError;
import com.atgrand.functional.option.IOption;
import com.atgrand.functional.option.none;
import com.atgrand.functional.option.some;
import com.atgrand.functional.tuple.ITuple2;
import com.atgrand.functional.tuple.tuple2;
import com.atgrand.functional.util.eq;
import com.atgrand.functional.util.require;
import com.atgrand.functional.util.verifiedType;
import com.atgrand.functional.wildcard.fun;

import flash.utils.Dictionary;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

public final class List extends Product implements IImmutable, IFuncList {
    /**
     * Creates and returns a closure accepting a function to fill a list
     * with a defined amount of elements.
     *
     * @param n The size of the list.
     * @return A closure to populate the list.
     *
     * @example
     * <pre>
     *   List.fill(3)(function(): Sprite { return new Sprite })
     * </pre>
     */
    public static function fill(n:int):Function {
        return function (x:Function):IFuncList {
            var l:IFuncList = nil;

            while (--n > -1) {
                l = l.prepend(x())
            }

            return l
        }
    }

    /**
     * Creates and returns a list based on a given array.
     *
     * @param array The array to transform to a list.
     * @return The List.&lt;A&gt; representation of a given Array.&lt;A&gt;.
     */
    public static function fromArray(array:Array):IFuncList {
        var l:IFuncList = nil;
        var n:int = array.length;

        while (--n > -1) {
            l = l.prepend(array[n])
        }

        return l
    }

    /**
     * Creates and returns a list based on a given string.
     *
     * @param string The string to transform to a list.
     * @return The List.&lt;String&gt; representation of a given string.
     */
    public static function fromString(string:String):IFuncList {
        var l:IFuncList = nil;
        var n:int = string.length;

        while (--n > -1) {
            l = l.prepend(string.substr(n, 1))
        }

        return l
    }

    /**
     * Private backing variable for the head property.
     * @private
     */
    private var _head:*;

    /**
     * Private backing variable for the tail property.
     * @private
     */
    private var _tail:IFuncList;

    /**
     * Private backing variable for the length property.
     * @private
     */
    private var _length:int = 0;

    /**
     * Whether or not the length has already been computed once.
     * @private
     */
    private var _lengthKnown:Boolean = false;

    /**
     * Creates and returns a new List object.
     *
     * @param head The head of the list.
     * @param tail The tail of the list.
     */
    public function List(head:*, tail:IFuncList) {
        _head = head;
        _tail = tail
    }

    /**
     * @inheritDoc
     */
    [Deprecated(replacement="size", since="1.0")]
    public function get length():int {
        return _lengthKnown ? _length : size
    }

    /**
     * @inheritDoc
     */
    public function get size():int {
        if (_lengthKnown) {
            return _length
        }

        var p:IFuncList = this;
        var length:int = 0;

        while (p.nonEmpty) {
            ++length;
            p = p.tail
        }

        _length = length;
        _lengthKnown = true;

        return length
    }

    /**
     * @inheritDoc
     */
    public function get hasDefinedSize():Boolean {
        return true
    }

    /**
     * @inheritDoc
     */
    override public function equals(that:IFunkObject):Boolean {
        if (that is IFuncList) {
            return super.equals(that)
        }

        return false
    }

    /**
     * @inheritDoc
     */
    override public function get productArity():int {
        return size
    }

    /**
     * @inheritDoc
     */
    override public function productElement(i:int):* {
        validateIndex(i);

        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (i == 0) {
                return p.head
            }

            p = p.tail;
            i -= 1
        }

        throw new NoSuchElementError()
    }

    /**
     * @inheritDoc
     */
    override public function get productPrefix():String {
        return "List"
    }

    /**
     * @inheritDoc
     */
    public function prepend(value:*):IFuncList {
        return new List(value, this)
    }

    /**
     * @inheritDoc
     */
    public function prependAll(value:IFuncList):IFuncList {
        const n:int = value.size;

        if (0 == n) {
            return this
        }

        const buffer:Vector.<List> = new Vector.<List>(n, true);
        const m:int = n - 1;
        var p:IFuncList = value;
        var i:int, j:int;

        i = 0;

        while (p.nonEmpty) {
            buffer[i++] = new List(p.head, null);
            p = p.tail
        }

        buffer[m]._tail = this;

        for (i = 0, j = 1; i < m; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function get(i:int):* {
        return productElement(i)
    }

    /**
     * @inheritDoc
     */
    public function contains(value:*):Boolean {
        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (eq(p.head, value)) {
                return true
            }
            p = p.tail
        }

        return false
    }

    /**
     * @inheritDoc
     */
    public function count(f:*):int {
        f = fun(f);
        
        var n:int = 0;
        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (f(p.head)) {
                ++n
            }

            p = p.tail
        }

        return n
    }

    /**
     * @inheritDoc
     */
    public function get nonEmpty():Boolean {
        return true
    }

    /**
     * @inheritDoc
     */
    public function drop(n:int):IFuncList {
        require(n >= 0, "n must be positive.");

        var p:IFuncList = this;

        for (var i:int = 0; i < n; ++i) {
            if (p.isEmpty) {
                return nil
            }

            p = p.tail
        }

        return p
    }

    /**
     * @inheritDoc
     */
    public function dropRight(n:int):IFuncList {
        require(n >= 0, "n must be positive.");

        if (0 == n) {
            return this
        }

        n = size - n;

        if (n <= 0) {
            return nil
        }

        const buffer:Vector.<List> = new Vector.<List>(n, true);
        const m:int = n - 1;
        var p:IFuncList = this;
        var i:int, j:int;

        for (i = 0; i < n; ++i) {
            buffer[i] = new List(p.head, null);
            p = p.tail
        }

        buffer[m]._tail = nil;

        for (i = 0, j = 1; i < m; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function dropWhile(f:Function):IFuncList {
        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (!f(p.head)) {
                return p
            }

            p = p.tail
        }

        return nil
    }

    /**
     * @inheritDoc
     */
    public function exists(f:*):Boolean {
        f = fun(f);

        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (f(p.head)) {
                return true
            }

            p = p.tail
        }

        return false
    }

    /**
     * @inheritDoc
     */
    public function filter(f:*):IFuncList {

        f = fun(f);

        var p:IFuncList = this;
        var q:List = null;
        var first:List = null;
        var last:List = null;
        var allFiltered:Boolean = true;

        while (p.nonEmpty) {
            if (f(p.head)) {
                q = new List(p.head, nil);

                if (null != last) {
                    last._tail = q
                }

                if (null == first) {
                    first = q
                }

                last = q
            }
            else {
                allFiltered = false
            }

            p = p.tail
        }

        if (allFiltered) {
            return this
        }

        return (first == null) ? nil : first
    }

    /**
     * @inheritDoc
     */
    public function filterNot(f:Function):IFuncList {
        var p:IFuncList = this;
        var q:List = null;
        var first:List = null;
        var last:List = null;
        var allFiltered:Boolean = true;

        while (p.nonEmpty) {
            if (!f(p.head)) {
                q = new List(p.head, nil);

                if (null != last) {
                    last._tail = q
                }

                if (null == first) {
                    first = q
                }

                last = q
            }
            else {
                allFiltered = false
            }

            p = p.tail
        }

        if (allFiltered) {
            return this
        }

        return (first == null) ? nil : first
    }

    /**
     * @inheritDoc
     */
    public function find(f:*):* {
        f = fun(f);

        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (f(p.head)) {
                return p.head
            }

            p = p.tail
        }

        return null
    }

    /**
     * @inheritDoc
     */
    public function flatMap(f:Function):IFuncList {
        var n:int = size;
        const buffer:Vector.<IFuncList> = new Vector.<IFuncList>(n, true);
        var p:IFuncList = this;
        var i:int;

        while (p.nonEmpty) {
            buffer[i++] = IFuncList(verifiedType(f(p.head), IFuncList));
            p = p.tail
        }

        var list:IFuncList = buffer[--n];

        while (--n > -1) {
            list = list.prependAll(buffer[n])
        }

        return list
    }

    /**
     * @inheritDoc
     */
    public function foldLeft(x:*, f:Function):* {
        var value:* = x;
        var p:IFuncList = this;

        while (p.nonEmpty) {
            value = f(value, p.head);
            p = p.tail
        }

        return value
    }

    /**
     * @inheritDoc
     */
    public function foldRight(x:*, f:Function):* {
        var value:* = x;
        var buffer:Array = toArray;
        var n:int = buffer.length;

        while (--n > -1) {
            value = f(value, buffer[n])
        }

        return value
    }

    /**
     * @inheritDoc
     */
    public function forall(f:Function):Boolean {
        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (!f(p.head)) {
                return false
            }

            p = p.tail
        }

        return true
    }

    /**
     * @inheritDoc
     */
    public function foreach(f:Function):void {
        var p:IFuncList = this;

        while (p.nonEmpty) {
            f(p.head);
            p = p.tail
        }
    }

    /**
     * @inheritDoc
     */
    public function get head():* {
        return _head
    }

    /**
     * @inheritDoc
     */
    public function get headOption():IOption {
        return some(_head)
    }

    /**
     * @inheritDoc
     */
    public function get indices():IFuncList {
        var n:int = size;
        var p:IFuncList = nil;

        while (--n > -1) {
            p = p.prepend(n)
        }

        return p
    }

    /**
     * @inheritDoc
     */
    public function get init():IFuncList {
        return dropRight(1)
    }

    /**
     * @inheritDoc
     */
    public function get isEmpty():Boolean {
        return false
    }

    /**
     * @inheritDoc
     */
    public function get last():* {
        var p:IFuncList = this;
        var value:* = null;
        while (p.nonEmpty) {
            value = p.head;
            p = p.tail
        }

        return value
    }

    /**
     * @inheritDoc
     */
    public function get lastOrNull():* {
        return last;
    }

    /**
     * @inheritDoc
     */
    public function map(f:*):IFuncList {
        f = fun(f);

        const n:int = size;
        const buffer:Vector.<List> = new Vector.<List>(n, true);
        const m:int = n - 1;

        var p:IFuncList = this;
        var i:int, j:int;

        for (i = 0; i < n; ++i) {
            buffer[i] = new List(f(p.head), null);
            p = p.tail
        }

        buffer[m]._tail = nil;

        for (i = 0, j = 1; i < m; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function partition(f:Function):ITuple2 {
        const left:Vector.<List> = new Vector.<List>();
        const right:Vector.<List> = new Vector.<List>();

        var i:int = 0;
        var j:int = 0;
        var m:int;
        var o:int;

        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (f(p.head)) {
                left[i++] = new List(p.head, nil)
            }
            else {
                right[j++] = new List(p.head, nil)
            }

            p = p.tail
        }

        m = i - 1;
        o = j - 1;

        if (m > 0) {
            for (i = 0, j = 1; i < m; ++i, ++j) {
                left[i]._tail = left[j]
            }
        }

        if (o > 0) {
            for (i = 0, j = 1; i < o; ++i, ++j) {
                right[i]._tail = right[j]
            }
        }

        return tuple2(m > 0 ? left[0] : nil, o > 0 ? right[0] : nil)
    }

    /**
     * @inheritDoc
     */
    public function reduceLeft(f:Function):* {
        var value:* = head;
        var p:IFuncList = this._tail;

        while (p.nonEmpty) {
            value = f(value, p.head);
            p = p.tail
        }

        return value
    }

    /**
     * @inheritDoc
     */
    public function reduceRight(f:Function):* {
        var buffer:Array = toArray;
        var value:* = buffer.pop();
        var n:int = buffer.length;

        while (--n > -1) {
            value = f(value, buffer[n])
        }

        return value
    }

    /**
     * @inheritDoc
     */
    public function get reverse():IFuncList {
        var result:IFuncList = nil;
        var p:IFuncList = this;

        while (p.nonEmpty) {
            result = result.prepend(p.head);
            p = p.tail
        }

        return result
    }

    /**
     * @inheritDoc
     */
    public function get tail():IFuncList {
        return _tail
    }

    /**
     * @inheritDoc
     */
    public function get tailOption():IOption {
        return some(_tail)
    }

    /**
     * @inheritDoc
     */
    public function take(n:int):IFuncList {
        require(n >= 0, "n must be positive.");

        if (n > size) {
            return this
        } else if (0 == n) {
            return nil
        }

        const buffer:Vector.<List> = new Vector.<List>(n, true);
        const m:int = n - 1;
        var p:IFuncList = this;
        var i:int, j:int;

        for (i = 0; i < n; ++i) {
            buffer[i] = new List(p.head, null);
            p = p.tail
        }

        buffer[m]._tail = nil;

        for (i = 0, j = 1; i < m; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function takeRight(n:int):IFuncList {
        require(n >= 0, "n must be positive.");

        if (n > size) {
            return this
        } else if (0 == n) {
            return nil
        }

        n = size - n;

        if (n <= 0) {
            return this
        }

        var p:IFuncList = this;

        for (var i:int = 0; i < n; ++i) {
            p = p.tail
        }

        return p
    }

    /**
     * @inheritDoc
     */
    public function takeWhile(f:Function):IFuncList {
        const buffer:Vector.<List> = new Vector.<List>();
        var p:IFuncList = this;
        var i:int, j:int;
        var n:int = 0;

        while (p.nonEmpty) {
            if (f(p)) {
                buffer[n++] = new List(p.head, null);
                p = p.tail
            }
            else {
                break
            }
        }

        const m:int = n - 1;

        if (m <= 0) {
            return nil
        }

        buffer[m]._tail = nil;

        for (i = 0, j = 1; i < m; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function get toArray():Array {
        const n:int = size;
        const array:Array = new Array(n);
        var p:IFuncList = this;
        var i:int;

        for (i = 0; i < n; ++i) {
            array[i] = p.head;
            p = p.tail
        }

        return array
    }

    /**
     * @inheritDoc
     */
    public function zip(that:IFuncList):IFuncList {
        const n:int = Math.min(size, that.size);
        const m:int = n - 1;
        const buffer:Vector.<List> = new Vector.<List>(n, true);
        var i:int, j:int;

        var p:IFuncList = this, q:IFuncList = that;

        for (i = 0; i < n; ++i) {
            buffer[i] = new List(tuple2(p.head, q.head), null);
            p = p.tail;
            q = q.tail
        }

        buffer[m]._tail = nil;

        for (i = 0, j = 1; i < m; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function get zipWithIndex():IFuncList {
        const n:int = size;
        const m:int = n - 1;
        const buffer:Vector.<List> = new Vector.<List>(n, true);
        var i:int, j:int;

        var p:IFuncList = this;

        for (i = 0; i < n; ++i) {
            buffer[i] = new List(tuple2(p.head, i), null);
            p = p.tail
        }

        buffer[m]._tail = nil;

        for (i = 0, j = 1; i < m; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function findIndexOf(f:Function):int {
        var index:int = 0;
        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (f(p.head)) {
                return index
            }

            p = p.tail;
            index += 1
        }

        return -1
    }

    /**
     * @inheritDoc
     */
    public function get flatten():IFuncList {
        return flatMap(function (x:*):IFuncList { return x is IFuncList ? x : toList(x) })
    }

    /**
     * @inheritDoc
     */
    public function indexOf(value:*):int {
        var index:int = 0;
        var p:IFuncList = this;

        while (p.nonEmpty) {
            if (eq(p.head, value)) {
                return index
            }

            p = p.tail;
            index += 1
        }

        return -1
    }

    /**
     * @inheritDoc
     */
    override public function mkString(separator:String):String {
        const n:int = size;
        const m:int = n - 1;

        var buffer:String = "";
        var p:IFuncList = this;
        var i:int;

        for (i = 0; i < n; ++i) {
            buffer += p.head;

            if (i != m) {
                buffer += separator
            }

            p = p.tail
        }

        return buffer
    }

    /**
     * @inheritDoc
     */
    override public function get iterator():IFuncIterator {
        return new ListIterator(this)
    }

    /**
     * @inheritDoc
     */
    public function append(value:*):IFuncList {
        const n:int = size;
        const buffer:Vector.<List> = new Vector.<List>(n + 1, true);
        var p:IFuncList = this;
        var i:int, j:int;

        i = 0;

        while (p.nonEmpty) {
            buffer[i++] = new List(p.head, null);
            p = p.tail
        }

        buffer[n] = new List(value, nil);

        for (i = 0, j = 1; i < n; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function appendAll(value:IFuncList):IFuncList {
        const n:int = size;
        const m:int = n - 1;
        const buffer:Vector.<List> = new Vector.<List>(n, true);
        var p:IFuncList = this;
        var i:int, j:int;

        i = 0;

        while (p.nonEmpty) {
            buffer[i++] = new List(p.head, null);
            p = p.tail
        }

        buffer[m]._tail = value;

        for (i = 0, j = 1; i < m; ++i, ++j) {
            buffer[i]._tail = buffer[j]
        }

        return buffer[0]
    }

    /**
     * @inheritDoc
     */
    public function prependIterator(iterator:IFuncIterator):IFuncList {
        return prependAll(iterator.toList)
    }

    /**
     * @inheritDoc
     */
    public function appendIterator(iterator:IFuncIterator):IFuncList {
        return appendAll(iterator.toList)
    }

    /**
     * @inheritDoc
     */
    public function prependIterable(iterable:IFuncIterable):IFuncList {
        return prependAll(iterable.iterator.toList)
    }

    /**
     * @inheritDoc
     */
    public function appendIterable(iterable:IFuncIterable):IFuncList {
        return appendAll(iterable.iterator.toList)
    }

    /**
     * @inheritDoc
     */
    public function get list():ArrayList {
        return new ArrayList(toArray);
    }

    /**
     * @inheritDoc
     */
    public function get collection():ArrayCollection {
        return new ArrayCollection(toArray);
    }

    /**
     * @inheritDoc
     */
    public function get array():Array {
        return toArray;
    }

    /**
     * @inheritDoc
     */
    public function get to_a():Array {
        return toArray;
    }

    public function uniq(f:*):IFuncList {
        var p:IFuncList = this;
        var q:List = null;
        var first:List = null;
        var last:List = null;
        var allFiltered:Boolean = true;
        var unique:Dictionary = new Dictionary();

        while (p.nonEmpty) {
            var r:* = f(p.head);
            if (!unique[r]) {
                unique[r] = true;
                q = new List(p.head, nil);

                if (null != last) {
                    last._tail = q
                }

                if (null == first) {
                    first = q
                }

                last = q
            }
            else {
                allFiltered = false
            }

            p = p.tail
        }

        if (allFiltered) {
            return this
        }

        return (first == null) ? nil : first
    }
}
}