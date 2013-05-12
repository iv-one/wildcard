package com.atgrand.functional.ioc.error {
public class IOCError extends Error {
    public function IOCError(message:String = "", id:int = 0) {
        super(message, id)
    }
}
}