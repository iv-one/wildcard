package com.atgrand.functional.collections {
import com.atgrand.functional.IImmutable
import com.atgrand.functional.Product
import com.atgrand.functional.collections.immutable.List
import com.atgrand.functional.error.NoSuchElementError
import com.atgrand.functional.option.IOption
import com.atgrand.functional.option.none
import com.atgrand.functional.tuple.ITuple2
import com.atgrand.functional.tuple.tuple2
import com.atgrand.functional.util.require

import mx.collections.ArrayCollection;

import mx.collections.ArrayList;

internal final class NilImpl extends Product implements IImmutable, IList {
    /**
     * @inheritDoc
     */
    public function contains(value:*):Boolean {
        return false
    }

    /**
     * @inheritDoc
     */
    public function count(f:*):int {
        return 0
    }

    /**
     * @inheritDoc
     */
    public function get nonEmpty():Boolean {
        return false
    }

    /**
     * @inheritDoc
     */
    public function drop(n:int):IList {
        require(n >= 0, "n must be positive.")
        return this
    }

    /**
     * @inheritDoc
     */
    public function dropRight(n:int):IList {
        require(n >= 0, "n must be positive.")
        return this
    }

    /**
     * @inheritDoc
     */
    public function dropWhile(f:Function):IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function exists(f:*):Boolean {
        return false
    }

    /**
     * @inheritDoc
     */
    public function filter(f:*):IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function filterNot(f:Function):IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function find(f:*):* {
        return null
    }

    /**
     * @inheritDoc
     */
    public function flatMap(f:Function):IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function foldLeft(x:*, f:Function):* {
        return x
    }

    /**
     * @inheritDoc
     */
    public function foldRight(x:*, f:Function):* {
        return x
    }

    /**
     * @inheritDoc
     */
    public function forall(f:Function):Boolean {
        return false
    }

    /**
     * @inheritDoc
     */
    public function foreach(f:Function):void {
    }

    /**
     * @inheritDoc
     */
    public function get (index:int):* {
        throw new RangeError()
    }

    /**
     * @inheritDoc
     */
    public function get head():* {
        throw new NoSuchElementError()
    }

    /**
     * @inheritDoc
     */
    public function get headOption():IOption {
        return none
    }

    /**
     * @inheritDoc
     */
    public function get indices():IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function get init():IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function get isEmpty():Boolean {
        return true
    }

    /**
     * @inheritDoc
     */
    public function get last():* {
        throw new NoSuchElementError()
    }

    /**
     * @inheritDoc
     */
    public function get lastOrNull():* {
        return null;
    }

    /**
     * @inheritDoc
     */
    public function map(f:*):IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function partition(f:Function):ITuple2 {
        return tuple2(this, this)
    }

    /**
     * @inheritDoc
     */
    public function prepend(value:*):IList {
        return new List(value, this)
    }

    /**
     * @inheritDoc
     */
    public function prependAll(value:IList):IList {
        return value
    }

    /**
     * @inheritDoc
     */
    public function reduceLeft(f:Function):* {
        return undefined
    }

    /**
     * @inheritDoc
     */
    public function reduceRight(f:Function):* {
        return undefined
    }

    /**
     * @inheritDoc
     */
    public function get reverse():IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function get tail():IList {
        throw new NoSuchElementError()
    }

    /**
     * @inheritDoc
     */
    public function get tailOption():IOption {
        return none
    }

    /**
     * @inheritDoc
     */
    public function take(n:int):IList {
        require(n >= 0, "n must be positive.")
        return this
    }

    /**
     * @inheritDoc
     */
    public function takeRight(n:int):IList {
        require(n >= 0, "n must be positive.")
        return this
    }

    /**
     * @inheritDoc
     */
    public function takeWhile(f:Function):IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function zip(that:IList):IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function get zipWithIndex():IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function get size():int {
        return 0
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
    public function get toArray():Array {
        return []
    }

    /**
     * @inheritDoc
     */
    public function findIndexOf(f:Function):int {
        return -1
    }

    /**
     * @inheritDoc
     */
    public function get flatten():IList {
        return this
    }

    /**
     * @inheritDoc
     */
    public function indexOf(value:*):int {
        return -1
    }

    /**
     * @inheritDoc
     */
    override public function get productArity():int {
        return 0
    }

    /**
     * @inheritDoc
     */
    override public function productElement(i:int):* {
        throw new RangeError()
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
    override public function toString():String {
        return "List()"
    }

    /**
     * @inheritDoc
     */
    override public function mkString(separator:String):String {
        return ""
    }

    /**
     * @inheritDoc
     */
    [Deprecated(replacement="size", since="1.0")]
    public function get length():int {
        return 0
    }

    /**
     * @inheritDoc
     */
    public function prependIterator(iterator:IIterator):IList {
        return iterator.toList
    }

    /**
     * @inheritDoc
     */
    public function prependIterable(iterable:IIterable):IList {
        return iterable.iterator.toList
    }

    /**
     * @inheritDoc
     */
    public function append(value:*):IList {
        return new List(value, this)
    }

    /**
     * @inheritDoc
     */
    public function appendAll(value:IList):IList {
        return value
    }

    /**
     * @inheritDoc
     */
    public function appendIterator(iterator:IIterator):IList {
        return iterator.toList
    }

    /**
     * @inheritDoc
     */
    public function appendIterable(iterable:IIterable):IList {
        return iterable.iterator.toList
    }

    /**
     * @inheritDoc
     */
    override public function get iterator():IIterator {
        return NilIterator.INSTANCE
    }

    public function get list():ArrayList {
        return new ArrayList();
    }

    public function get collection():ArrayCollection {
        return new ArrayCollection();
    }

    public function get array():Array {
        return [];
    }

    public function get to_a():Array {
        return [];
    }

    public function uniq(f:*):IList {
        return nil;
    }
}
}