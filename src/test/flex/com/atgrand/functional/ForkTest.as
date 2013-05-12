package com.atgrand.functional {
import org.flexunit.asserts.assertEquals;

public final class ForkTest {
    [Test]
    public function testForkAndThenWithoutForce():void {
        var n:int = 0;
        var f:Function = fork(
                function (next:Function):void {
                    assertEquals(1, ++n);
                    next()
                }
        ).andThen(
                function ():void {
                    assertEquals(2, ++n)
                }
        );

        assertEquals(0, n);
        f();
        assertEquals(2, n)
    }

    [Test]
    public function testForkAndThenWithForce():void {
        var n:int = 0;
        var f:Function = fork(
                function (next:Function):void {
                    assertEquals(1, ++n);
                    next()
                }, null, null, true
        ).andThen(
                function ():void {
                    assertEquals(2, ++n)
                }
        );

        assertEquals(0, n);
        f();
        assertEquals(0, n)
    }

    [Test]
    public function testForkAndContinueWithoutForce():void {
        var n:int = 0;
        var f:Function = fork(
                function (next:Function):void {
                    assertEquals(1, ++n);
                    next(n)
                }
        ).andContinue(
                function (x:int):void {
                    assertEquals(n, x);
                    assertEquals(2, ++n)
                });

        assertEquals(0, n);
        f();
        assertEquals(2, n)
    }

    [Test]
    public function testForkAndContinueWithForce():void {
        var n:int = 0;
        var f:Function = fork(
                function (next:Function):void {
                    assertEquals(1, ++n);
                    next(n)
                }, null, null, true
        ).andContinue(
                function (x:int):void {
                    assertEquals(n, x);
                    assertEquals(2, ++n)
                });

        assertEquals(0, n);
        f();
        assertEquals(0, n)
    }
}
}