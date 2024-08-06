try
{
	save();
}
catch(error)
{
	show_message_async($"Failed to save file (3.bin) (report to dev):\n{error.longMessage}");
}