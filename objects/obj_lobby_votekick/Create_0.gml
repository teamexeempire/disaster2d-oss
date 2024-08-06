packet = PacketType.CLIENT_LOBBY_CHOOSEVOTEKICK;
ind = 0;

with(obj_lobby)
{
	lobby_add_message("\\()~", "choose the player");
	lobby_add_message("\\()~", "(press \\x~ to cancel)");
	voteKick = true;
}

obj_controls.jUse = true;