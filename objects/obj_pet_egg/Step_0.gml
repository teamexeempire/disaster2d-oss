if(!instance_exists(target))
{
	instance_destroy();
	return;
}

visible = target.visible;