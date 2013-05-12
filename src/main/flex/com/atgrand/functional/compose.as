package com.atgrand.functional {
/**
 * f(g(x))
 * @param f
 * @param g
 */
public function compose(f:Function, g:Function):Function {
    return f != null && g != null ?
           function (...rest):* {return f(g.apply(null, rest))} :
           f || g;
}
}