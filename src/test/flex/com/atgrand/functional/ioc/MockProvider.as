package com.atgrand.functional.ioc {
  import flexunit.framework.Assert

  internal final class MockProvider implements IProvider, IMockProvider {
    private const _injectedSingleton: SingletonInstance = inject(SingletonInstance);

    public function get(): * {
      Assert.assertNotNull(_injectedSingleton);
      return new ProvidedObject()
    }
  }
}