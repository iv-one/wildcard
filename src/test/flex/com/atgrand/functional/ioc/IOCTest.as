package com.atgrand.functional.ioc {
import com.atgrand.functional.closure;
import com.atgrand.functional.ioc.error.BindingError;
import com.atgrand.functional.test.assertThrows;

import flash.display.Sprite;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;

public final class IOCTest {
    [Test]
    public function testIOC():void {
        const module:IModule = Injector.initialize(new MockModule);
        const mockObject:MockObject = module.getInstance(MockObject);

        assertEquals("Test", mockObject.byInstance);
        assertTrue(mockObject.byProvider is ProvidedObject);
        assertTrue(mockObject.byObject is AnotherObject);
        assertEquals(1, SingletonInstance.numInstances);

        const mockObject2:MockObject = module.getInstance(MockObject);

        assertEquals("Test", mockObject2.byInstance);
        assertTrue(mockObject2.byProvider is ProvidedObject);
        assertTrue(mockObject2.byObject is AnotherObject);
        assertEquals(1, SingletonInstance.numInstances);

        assertFalse(mockObject.byProvider == mockObject2.byProvider);
        assertFalse(mockObject.byObject == mockObject2.byObject);

        assertThrows(closure(inject, null), ArgumentError);
        assertThrows(closure(inject, Sprite), BindingError);

        const mockObject3:MockObject = new MockObject();

        assertEquals("Test", mockObject3.byInstance);
        assertTrue(mockObject3.byProvider is ProvidedObject);
        assertTrue(mockObject3.byObject is AnotherObject);
        assertEquals(1, SingletonInstance.numInstances)
    }
}
}