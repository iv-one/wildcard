/**
 * Author: Ivan Dyachenko <ivan.dyachenko@db.com>
 * Date: 15.12.11
 * Time: 14:10
 */
package com.atgrand.functional {

import flash.utils.Proxy;
import flash.utils.flash_proxy;

internal final dynamic class CompositeWildcard extends Proxy implements ICompositeWildcard {

    private var _f:Function;

    public function CompositeWildcard(f:Function = null) {
        _f = f;
    }

    public function get f():Function {
        return _f;
    }

    /**
     *
     * @param g - Function
     * @return composite self.f(g(...)
     */
    private function composite(g:Function):CompositeWildcard {
        return new CompositeWildcard(compose(g, f));
    }

    /**
     * @inheritDoc
     */
    flash_proxy override function callProperty(name:*, ...args):* {
        var g:Function = function (x:*):* {
                return _.hasOwnProperty(name) ?
                       _[name](x).apply(null, args) :
                       x[name].apply(x, args);
            };

        return composite(g);
    }

    /**
     * @inheritDoc
     */
    flash_proxy override function getProperty(name:*):* {
        var g:Function = function (x:*):* {
            return _.hasOwnProperty(name) ?
                   _[name](x) :
                   x[name];
        };

        return composite(g);
    }

}
}
