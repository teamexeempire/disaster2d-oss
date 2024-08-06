package com.teamexeempire.disaster2d;

public class Disaster
{
	public static native boolean disaster_start();

	static 
	{
		System.loadLibrary("DisasterServer");
	}
}