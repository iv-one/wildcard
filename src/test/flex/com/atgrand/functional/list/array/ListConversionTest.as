/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 11.01.12
 * Time: 14:07
 */
package com.atgrand.functional.list.array {

import com.atgrand.functional.collections.list;
import com.atgrand.functional.collections.nil;
import com.atgrand.functional.range;
import com.atgrand.testing.bdd.base.Specifications;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

public class ListConversionTest extends Specifications{
    [Test]
    public function should_convert_to_array():void {
        it(range(1, 4).to_a).should.be.array.like([1, 2, 3, 4]);
        it(range(1, 4).array).should.be.array.like([1, 2, 3, 4]);
    }

    [Test]
    public function should_convert_to_array_collection():void {
        with (it(list(1, 2, 3).collection)) {
            should.be.kind.of(ArrayCollection);
            should.be.list.like([1, 2, 3]);
        }
    }

    [Test]
    public function should_convert_to_array_list():void {
        with (it(list(1, 2, 3).list)) {
            should.be.kind.of(ArrayList);
            should.be.list.like([1, 2, 3]);
        }
    }

    [Test]
    public function nil_should_convert_to_empty_array():void {
        it(nil.to_a).should.be.empty();
        it(nil.array).should.be.empty();
    }

    [Test]
    public function nil_should_convert_to_ilist_without_items():void {
        it(nil.collection.length).should.equal(0);
        it(nil.list.length).should.equal(0);
    }
}
}
