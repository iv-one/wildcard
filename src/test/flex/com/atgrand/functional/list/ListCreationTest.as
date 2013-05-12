/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 15.12.11
 * Time: 15:34
 */
package com.atgrand.functional.list {
import com.atgrand.functional.collections.list;
import com.atgrand.functional.collections.nil;
import com.atgrand.functional.range;
import com.atgrand.testing.bdd.base.Specifications;

import mx.collections.ArrayCollection;
import mx.collections.ArrayList;

public class ListCreationTest extends Specifications{
    [Test]
    public function should_create_list_from_rest_params():void {
        it(list(0, 1, 2, 3).equals(range(0, 3))).should.be._true();
    }

    [Test]
    public function should_create_list_from_array():void {
        it(list([0, 1, 2, 3]).equals(range(0, 3))).should.be._true();
    }

    [Test]
    public function should_create_list_from_IList():void {
        it(list(new ArrayCollection([0, 1, 2, 3])).equals(range(0, 3))).should.be._true();
        it(list(new ArrayList([0, 1, 2, 3])).equals(range(0, 3))).should.be._true();
    }

    [Test]
    public function should_return_nil_for_null():void {
        it(list(null)).should.equal(nil);
    }

}
}
