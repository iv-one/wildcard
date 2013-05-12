package com.atgrand.functional.ioc.error {
public class BindingError extends IOCError {
    public function BindingError(message:String = "", id:int = 0) {
        super(message, id)
    }
}
}