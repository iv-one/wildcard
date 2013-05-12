package com.atgrand.functional.ioc {
  internal final class MockModule extends AbstractModule {
    override final protected function configure(): void {
      bind(IMockProviderObject).toProvider(IMockProvider);
      bind(IMockProvider).to(MockProvider);
      bind(String).toInstance("Test");
      bind(IAnotherObject).to(AnotherObject);
      bind(SingletonInstance).asSingleton()
    }
  }
}