if(state != 0)
	return;
	
if(!canUse || voteKick)
	return;

if(!chatMode)
{
	chatMode = true;
	keyboard_string = chatMsg;
}