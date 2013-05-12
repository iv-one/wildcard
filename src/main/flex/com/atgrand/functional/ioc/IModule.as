package com.atgrand.functional.ioc {
public interface IModule {
    function initialize():void

    function getInstance(klass:Class):*

    function binds(klass:Class):Boolean
}
}