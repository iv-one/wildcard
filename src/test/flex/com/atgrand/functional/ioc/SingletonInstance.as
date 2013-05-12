package com.atgrand.functional.ioc {
  internal final class SingletonInstance {
    public static var numInstances: int = 0;
    
    public function SingletonInstance() {
      numInstances += 1
    }
  }
}