package com.atgrand.functional.ioc {
internal final class MockObject {
    private const _byProvider: IMockProviderObject = inject(IMockProviderObject);
    private const _byInstance: String = inject(String);
    private const _byObject: IAnotherObject = inject(IAnotherObject);
    private const _byObjectAsSingleton: SingletonInstance = inject(SingletonInstance);
    
    public function get byProvider(): IMockProviderObject {
      return _byProvider
    }

    public function get byInstance(): String {
      return _byInstance
    }

    public function get byObject(): IAnotherObject {
      return _byObject
    }
  }
}