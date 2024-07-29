package com.icia.guree.exception;

public class DBException extends RuntimeException{
    //필드,메소드 생략
    public DBException() {
        super("@Transaction은 기본적으로 RuntimeException 예외 발생하면 rollback처리됨");
    }
}
