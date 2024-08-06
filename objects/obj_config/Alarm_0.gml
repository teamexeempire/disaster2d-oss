if(!instance_exists(obj_menu))
	return;

obj_menu.findButton("ping").state = showPing;
obj_menu.findButton("fps").state = showFps;
obj_menu.findTextbox("ip").text = ip;
obj_menu.findTextbox("ip_mobile").text = ip;
obj_menu.findTextbox("nickname").text = global.nickname;
obj_menu.findTextpanel("left").text = scr_controls_keycode_to_key(global.KeyLeft);
obj_menu.findTextpanel("right").text = scr_controls_keycode_to_key(global.KeyRight);
obj_menu.findTextpanel("up").text = scr_controls_keycode_to_key(global.KeyUp);
obj_menu.findTextpanel("down").text = scr_controls_keycode_to_key(global.KeyDown);
obj_menu.findTextpanel("jump").text = scr_controls_keycode_to_key(global.KeyA);
obj_menu.findTextpanel("special1").text = scr_controls_keycode_to_key(global.KeyB);
obj_menu.findTextpanel("special2").text = scr_controls_keycode_to_key(global.KeyC);
obj_menu.findTextpanel("playerlist").text = scr_controls_keycode_to_key(global.KeyPList);
obj_menu.findTextpanel("emotion1").text = scr_controls_keycode_to_key(global.KeyEm1);
obj_menu.findTextpanel("emotion2").text = scr_controls_keycode_to_key(global.KeyEm2);
obj_menu.findTextpanel("emotion3").text = scr_controls_keycode_to_key(global.KeyEm3);
obj_menu.findTextpanel("emotion4").text = scr_controls_keycode_to_key(global.KeyIdle);
obj_menu.findTextpanel("hidegui").text = scr_controls_keycode_to_key(global.KeyHide);
