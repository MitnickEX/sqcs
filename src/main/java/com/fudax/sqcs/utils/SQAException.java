package com.fudax.sqcs.utils;

public class SQAException extends Exception {

	private static final long serialVersionUID = 1L;

	public SQAException() {
		super();
	}

	public SQAException(String message) {
		super(message);
	}

	public SQAException(String message, Throwable cause) {
		super(message, cause);
	}

	public SQAException(Throwable cause) {
		super(cause);
	}

}
