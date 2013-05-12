package com.atgrand.functional.ioc {
  import flexunit.framework.Assert

  internal final class ProvidedObject implements IMockProviderObject {
    private const _injectedSingleton: SingletonInstance = inject(SingletonInstance);

    public function ProvidedObject() {
      Assert.assertNotNull(_injectedSingleton)
    }
  }
}