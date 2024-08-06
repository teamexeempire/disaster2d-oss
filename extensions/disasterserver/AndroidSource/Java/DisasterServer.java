package ${YYAndroidPackageName};

import java.lang.Thread;

import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import static com.teamexeempire.disaster2d.Disaster.disaster_start;

public class DisasterServer
{
	public void Init() {}
	public double ServerStart()
	{
		return disaster_start() ? 1d : 0d;
	}
}