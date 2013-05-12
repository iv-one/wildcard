package com.atgrand.functional.option {
	/**
	 * Creates and returns a defined option.
	 * 
	 * @param value The value of the option.
	 * @return A defined <code>Option.&lt;A&gt;</code>
	 */
  public function some(value: *): IOption {
    return new SomeImpl(value)
  }
}