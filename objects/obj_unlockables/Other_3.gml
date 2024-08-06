try
{
	save();
}
catch(error)
{
	show_message_async($"Failed to save file (2.bson) (report to dev):\n{error.longMessage}");
}