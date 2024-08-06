global.net_effs = 
[
	spr_ring_sparkle,
	spr_ring_teleport,
	spr_blood1,
	spr_blood2,
	spr_blood3,
	spr_ringlose,
	spr_shieldbreak,
	spr_dust,
	spr_eggpack,
	spr_roseheart,
	spr_eroseheart,
	spr_shockparticle,
	spr_shieldbreak2,
	spr_blackring_sparkle,
	spr_blackring_sparkle_purple,
	spr_watersplash,
	spr_shard_sparkle
];
global.tmp_effid = 0;

function net_quick_effect(xx, yy, spr, fade = false, dir = 1, xspd = 0, yspd = 0, spd = 0.5)
{
	var inst = scr_effect_quick(xx, yy, spr, spd, fade, xspd, yspd);
	inst.image_xscale = dir;
	
	global.tmp_effid = spr;
	var packet = cpacket_tcp(PacketType.CLIENT_SPAWN_EFFECT, true);
	buffer_write(packet, buffer_u16, xx);
	buffer_write(packet, buffer_u16, yy);
	buffer_write(packet, buffer_bool, fade);
	buffer_write(packet, buffer_s8, dir);
	buffer_write(packet, buffer_u8, array_find_index(global.net_effs, function(_element, _index)
	{
	    return _element == global.tmp_effid;
	}));
	buffer_write(packet, buffer_s8, xspd);
	buffer_write(packet, buffer_s8, yspd);
	buffer_write(packet, buffer_f32, spd);
	send_server_tcp(packet);
}

function net_tails_spawn_projectile(xx, yy, dir, dmg, isExe, charge)
{	
	var packet = cpacket_tcp(PacketType.CLIENT_TPROJECTILE);
	buffer_write(packet, buffer_u16, xx);
	buffer_write(packet, buffer_u16, yy);
	buffer_write(packet, buffer_s8, dir);
	buffer_write(packet, buffer_u8, dmg);
	buffer_write(packet, buffer_bool, isExe);
	buffer_write(packet, buffer_u8, charge);
	send_server_tcp(packet);
}