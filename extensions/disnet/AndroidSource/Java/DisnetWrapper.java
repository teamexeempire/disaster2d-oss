package ${YYAndroidPackageName};

import java.nio.ByteBuffer;

import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import com.teamexeempire.disaster2d.Disnet;

public class DisnetWrapper
{
	public double disnet_init()
	{
		return Disnet.disnet_init();
	}

	public void disnet_reset()
	{
		Disnet.disnet_reset();
	}

	public double disnet_connect(String address, double port)
	{
		return Disnet.disnet_connect(address, port);
	}

	public double disnet_poll(ByteBuffer buffer)
	{
		return Disnet.disnet_poll(buffer);
	}

	public void disnet_send(ByteBuffer buffer, double length, double reliable)
	{
		Disnet.disnet_send(buffer, length, reliable);
	}
}