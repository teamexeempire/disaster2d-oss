package com.teamexeempire.disaster2d;

import java.lang.String;
import java.nio.ByteBuffer;

public class Disnet
{
	public static native double disnet_init();
	public static native void 	disnet_reset();
	public static native double disnet_connect(String address, double port);
	public static native double disnet_poll(ByteBuffer buffer);
	public static native void 	disnet_send(ByteBuffer buffer, double length, double reliable);

	static 
	{
		System.loadLibrary("disnet");
	}
}