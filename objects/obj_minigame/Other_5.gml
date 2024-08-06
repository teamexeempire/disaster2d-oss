if(cscore > hiscore)
{
	hiscore = cscore;
	
	try
	{
		var buff = buffer_create(4, buffer_fixed, 1);
		buffer_write(buff, buffer_u32, hiscore);
		buffer_save(buff, $"{game_save_id}/hiscore");
		buffer_delete(buff);
	}
	catch(error){}
}