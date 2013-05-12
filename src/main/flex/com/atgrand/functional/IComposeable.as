package com.atgrand.functional {
public interface IComposeable extends IFunkObject {
    /**
     * Builds and returns <code>h</code> with <code>h := g(x); f(y)</code>.
     *
     * g is usually defined in a different scope of the IComposable.
     *
     * @param f The function f in <code>g(x); f(y)</code>.
     * @param thisArg The <code>this</code> argument of the function f.
     * @param argArray The arguments for the given function.
     * @return The sequence <code>g(..?); f(x)</code>
     */
    function andThen(f:Function, thisArg:* = null, argArray:Array = null):Function

    /**
     * Builds and returns <code>h</code> with <code>h := f(g(x))</code>.
     *
     * g is usually defined in a different scope of the IComposable.
     *
     * @param f The function f in <code>f(g(x))</code>
     * @return The composition <code>f(g(x))</code>
     */
    function andContinue(f:Function):Function
}
}