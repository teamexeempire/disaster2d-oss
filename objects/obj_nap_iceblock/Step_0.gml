if(!instance_exists(obj_camera))
	return;

var gain = 1.0 - (min(distance_to_point(obj_camera.x + 213, obj_camera.y + 120), 700) / 700.0);
audio_emitter_position(emitter, x, y, 0);
audio_emitter_gain(emitter, gain);

if(!visible)
	return;

if(sprite_index == spr_nap_iceblock2 && image_index >= image_number - 1)
	sprite_index = spr_nap_iceblock;
	
var _inst = instance_place(x, y, obj_tails_projectile);
if(_inst != noone && _inst.isOwner)
{
	var pack = cpacket_tcp(PacketType.CLIENT_NAPICE_ACTIVATE);
	buffer_write(pack, buffer_u8, nid);
	send_server_tcp(pack);	
}

if(!instance_exists(global.player))
	return;

if(place_meeting(x, y, global.player) && global.character == CHARACTER_KNUX && global.player.state == KNUX_GLIDE)
{
	var pack = cpacket_tcp(PacketType.CLIENT_NAPICE_ACTIVATE);
	buffer_write(pack, buffer_u8, nid);
	send_server_tcp(pack);	
}