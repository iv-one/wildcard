package com.atgrand.functional {
	public function fork(f: Function, thisArg: * = null, argArray: Array = null, force: Boolean = false): IComposeable {
		return new ForkImpl(f, thisArg, argArray, force)
	}
}