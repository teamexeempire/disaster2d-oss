#macro SUBMENU_NONE 0
#macro SUBMENU_JOIN 1
#macro SUBMENU_JOIN_MOBILE 47

#macro SUBMENU_OPTIONSGENERAL 2
#macro SUBMENU_OPTIONSCONTROLS 3
#macro SUBMENU_OPTIONSBACK 4
#macro SUBMENU_OPTIONSCONTROLSMOBILE 5

#macro SUBMENU_MECH_SPIN 6
#macro SUBMENU_MECH_HIT 7
#macro SUBMENU_MECH_PAR 8
#macro SUBMENU_MECH_REB 9
#macro SUBMENU_MECH_STEAL 10
#macro SUBMENU_MECH_RINGS 11
#macro SUBMENU_MECH_REDRINGS 12
#macro SUBMENU_MECH_DEMON 13
#macro SUBMENU_MECH_SUDDEN 14
#macro SUBMENU_MECH_ESCAPE 15
#macro SUBMENU_MECH_DIFF 16

#macro SUBMENU_ABOUT_CREDITS 18
#macro SUBMENU_ABOUT_BACK 19

#macro SUBMENU_CHAR_TAILS 20
#macro SUBMENU_CHAR_KNUX 21
#macro SUBMENU_CHAR_EGG 22
#macro SUBMENU_CHAR_AMY 23
#macro SUBMENU_CHAR_CREAM 24
#macro SUBMENU_CHAR_SALLY 25
#macro SUBMENU_CHAR_EXE 26
#macro SUBMENU_CHAR_CHAOS 27
#macro SUBMENU_CHAR_EXETIOR 28
#macro SUBMENU_CHAR_EXELLER 29

#macro SUBMENU_EXTRA_ACHIVEMENTS 30
#macro SUBMENU_EXTRA_TAILS 31
#macro SUBMENU_EXTRA_KNUX 32
#macro SUBMENU_EXTRA_EGG 33
#macro SUBMENU_EXTRA_AMY 34
#macro SUBMENU_EXTRA_CREAM 35
#macro SUBMENU_EXTRA_SALLY 36
#macro SUBMENU_EXTRA_EXE 37
#macro SUBMENU_EXTRA_CHAOS 38
#macro SUBMENU_EXTRA_EXETIOR 39
#macro SUBMENU_EXTRA_EXELLER 40

#macro SUBMENU_EXTRA_SKINS1 41
#macro SUBMENU_EXTRA_SKINS2 42
#macro SUBMENU_EXTRA_SKINS3 43

#macro SUBMENU_EXTRA_BACK 44
#macro SUBMENU_EXTRA_TAUNT 45
#macro SUBMENU_EXTRA_PENIS 46

scheme = false;

bSelected = 0;
bCount = 5;

bSelectedColumn = 0;
bColumnCount = 0;
buttonA = false;

submenu = SUBMENU_NONE;
justEntered = true;

bind = false;
bindBtn = 0;
ignoreButtons = false;

mobSelectedButton = 0;

findButton = function(_tid)
{
	with(obj_menu_button)
	{
		if(tid == _tid)
			return self;
	}
	
	return noone;
}


findTextbox = function(_tid)
{
	with(obj_menu_textbox)
	{
		if(tid == _tid)
			return self;
	}
	
	return noone;
}

findTextpanel = function(_tid)
{
	with(obj_menu_textpanel)
	{
		if(tid == _tid)
			return self;
	}
	
	return noone;
}

bars = layer_background_get_id(layer_get_id("Bars"));

buttonListed = function(_bid, _bcolumn, _dir)
{
	switch(submenu)
	{		
		case SUBMENU_OPTIONSGENERAL:
			if(_bid == 1)
			{
				if(_dir)
				{
					if(++obj_config.screenMode > 3)
						obj_config.screenMode = 0;
				}
				else
				{
					if(--obj_config.screenMode < 0)
						obj_config.screenMode = 3;
				}
				
				obj_config.applyRes();
				obj_config.save();
				return true;
			}
			else
			{
				if(_bid != 4)
					break;
					
				if(_bcolumn > -1)
					break;
				
				if(_dir)
				{
					changeSubmenu(obj_controls.isMobile ? SUBMENU_OPTIONSCONTROLSMOBILE : SUBMENU_OPTIONSCONTROLS);
					
					if(os_type != os_android)
						buttonSelected(10, -1, -1, true);
				}
				else
				{
					changeSubmenu(SUBMENU_OPTIONSBACK);
					buttonSelected(0, -1, 0, true);
				}
				return true;
			}
			
		case SUBMENU_OPTIONSCONTROLS:
			if(_bid != 10)
				break;
		
			if(_dir)
			{
				changeSubmenu(SUBMENU_OPTIONSBACK);
				buttonSelected(0, -1, 0, true);
			}
			else
			{
				changeSubmenu(SUBMENU_OPTIONSGENERAL);
				buttonSelected(4, -1, 0, true);
			}
			return true;
			
		case SUBMENU_OPTIONSBACK:
			if(_dir)
			{
				changeSubmenu(SUBMENU_OPTIONSGENERAL);
				buttonSelected(4, -1, 0, true);
			}
			else
			{
				changeSubmenu(obj_controls.isMobile ? SUBMENU_OPTIONSCONTROLSMOBILE : SUBMENU_OPTIONSCONTROLS);
				
				if(os_type != os_android)
					buttonSelected(10, -1, -1, true);
			}
			return true;
			
		case SUBMENU_MECH_SPIN:
		case SUBMENU_MECH_STEAL:
		case SUBMENU_MECH_HIT:
		case SUBMENU_MECH_PAR:
		case SUBMENU_MECH_RINGS:
		case SUBMENU_MECH_REB:
		case SUBMENU_MECH_REDRINGS:
		case SUBMENU_MECH_DEMON:
		case SUBMENU_MECH_SUDDEN:
		case SUBMENU_MECH_ESCAPE:
		case SUBMENU_MECH_DIFF:
			if(_bid == 0)
			{
				if(_dir)
				{
					if(submenu + 1 > SUBMENU_MECH_DIFF)
					{
						changeSubmenu(SUBMENU_MECH_SPIN);
						break;
					}
					
					changeSubmenu(submenu + 1);
				}
				else
				{
					if(submenu - 1 < SUBMENU_MECH_SPIN)
					{
						changeSubmenu(SUBMENU_MECH_DIFF);
						break;
					}	
					
					changeSubmenu(submenu - 1);
				}
				
				with(obj_menu_gif)
					image_index = 0;
			}
			else
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_CHAR_TAILS);
					buttonSelected(1, 0, -1, true);
				}
				else
					changeSubmenu(SUBMENU_ABOUT_BACK);
			}
			break;
			
		case SUBMENU_CHAR_TAILS:
		case SUBMENU_CHAR_KNUX:
		case SUBMENU_CHAR_EGG:
		case SUBMENU_CHAR_AMY:
		case SUBMENU_CHAR_SALLY:
		case SUBMENU_CHAR_CREAM:
		case SUBMENU_CHAR_EXE:
		case SUBMENU_CHAR_CHAOS:
		case SUBMENU_CHAR_EXETIOR:
		case SUBMENU_CHAR_EXELLER:
			if(_bid == 0)
			{
				if(_dir)
				{
					if(submenu + 1 > SUBMENU_CHAR_EXELLER)
					{
						changeSubmenu(SUBMENU_CHAR_TAILS);
						break;
					}
					
					changeSubmenu(submenu + 1);
				}
				else
				{
					if(submenu - 1 < SUBMENU_CHAR_TAILS)
					{
						changeSubmenu(SUBMENU_CHAR_EXELLER);
						break;
					}	
					
					changeSubmenu(submenu - 1);
				}
				
				with(obj_menu_gif)
					image_index = 0;
			}
			else
			{
				if(_dir)
					changeSubmenu(SUBMENU_ABOUT_CREDITS);
				else
				{
					changeSubmenu(SUBMENU_MECH_SPIN);
					buttonSelected(1, 0, -1, false);
				}
			}
			break;
	
		case SUBMENU_ABOUT_CREDITS:
			if(_dir)
			{
				changeSubmenu(SUBMENU_ABOUT_BACK);
			}
			else
			{
				changeSubmenu(SUBMENU_CHAR_TAILS);
				buttonSelected(1, 0, 0, true);
			}
			break;
			
		case SUBMENU_ABOUT_BACK:
			if(_dir)
			{
				changeSubmenu(SUBMENU_MECH_SPIN);
				buttonSelected(1, 0, 0, true);
			}
			else
			{
				changeSubmenu(SUBMENU_ABOUT_CREDITS);
			}
			break;
		
		case SUBMENU_EXTRA_ACHIVEMENTS:
			if(_dir)
			{
				changeSubmenu(SUBMENU_EXTRA_TAILS);
				buttonSelected(3, -1, 0, true);
			}
			else
				changeSubmenu(SUBMENU_EXTRA_BACK);
			return true;
			
		case SUBMENU_EXTRA_BACK:
			if(_dir)
			{
				changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
				buttonSelected(0, -1, 0, true);
			}
			else
			{
				changeSubmenu(SUBMENU_EXTRA_TAUNT);
				buttonSelected(2, -1, 0, true);
			}
			return true;
			
		case SUBMENU_EXTRA_TAILS:
		case SUBMENU_EXTRA_KNUX:
		case SUBMENU_EXTRA_EGG:
		case SUBMENU_EXTRA_AMY:
		case SUBMENU_EXTRA_SALLY:
		case SUBMENU_EXTRA_CREAM:
			if(_bid == 0 && _bcolumn <= -1)
			{
				if(_dir)
				{
					if(submenu + 1 > SUBMENU_EXTRA_EXELLER)
					{
						changeSubmenu(SUBMENU_EXTRA_TAILS);
						buttonSelected(0, -1, 0, true);
						break;
					}
					
					changeSubmenu(submenu + 1);
				}
				else
				{
					if(submenu - 1 < SUBMENU_EXTRA_TAILS)
					{
						changeSubmenu(SUBMENU_EXTRA_EXELLER);
						break;
					}	
					
					changeSubmenu(submenu - 1);
				}
			}
			else if(_bid == 3)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(3, -1, 0, true);
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
					buttonSelected(0, -1, 0, true);
				}
			}
			break;
			
		case SUBMENU_EXTRA_EXE:
		case SUBMENU_EXTRA_CHAOS:
		case SUBMENU_EXTRA_EXETIOR:
		case SUBMENU_EXTRA_EXELLER:
			if(_bid == 0 && _bcolumn <= -1)
			{
				if(_dir)
				{
					if(submenu + 1 > SUBMENU_EXTRA_EXELLER)
					{
						changeSubmenu(SUBMENU_EXTRA_TAILS);
						buttonSelected(0, -1, 0, false);
						break;
					}
					
					changeSubmenu(submenu + 1);
				}
				else
				{
					if(submenu - 1 < SUBMENU_EXTRA_TAILS)
					{
						changeSubmenu(SUBMENU_EXTRA_EXELLER);
						break;
					}	
					
					changeSubmenu(submenu - 1);
				}
			}
			else if(_bid == 2)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(3, -1, 0, true);
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
					buttonSelected(0, -1, 0, true);
				}
			}
			break;
			
		case SUBMENU_EXTRA_SKINS1:
			if(_bid == 3)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_PENIS);
					buttonSelected(2, -1, 0, true);
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_TAILS);
					buttonSelected(3, -1, 0, true);
				}
				
				return true;
			}
			else if(_bid == 0)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS2);
					buttonSelected(0, -1, 0, true);
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS3);
					buttonSelected(0, -1, 0, true);
				}
			}
			break;
		
		case SUBMENU_EXTRA_SKINS2:
			if(_bid == 3)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_PENIS);
					buttonSelected(2, -1, 0, true);
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_TAILS);
					buttonSelected(3, -1, 0, true);
				}
			}
			else if(_bid == 0)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS3);
					buttonSelected(0, -1, 0, true);
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(0, -1, 0, true);
				}
				
				return true;
			}
			break;
			
		case SUBMENU_EXTRA_SKINS3:
			if(_bid == 2)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_PENIS);
					buttonSelected(2, -1, 0, true);
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_TAILS);
					buttonSelected(3, -1, 0, true);
				}
				return true;
			}
			else if(_bid == 0)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(0, -1, 0, true);
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS2);
					buttonSelected(0, -1, 0, true);
				}
			}
			break;
			
		case SUBMENU_EXTRA_PENIS:
			if(_bid == 2)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_TAUNT);
					buttonSelected(2, -1, 0, true);
					return true;
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(3, -1, 0, true);
				}
			}
			break;
			
		case SUBMENU_EXTRA_TAUNT:
			if(_bid == 2)
			{
				if(_dir)
				{
					changeSubmenu(SUBMENU_EXTRA_BACK);
					return true;
				}
				else
				{
					changeSubmenu(SUBMENU_EXTRA_PENIS);
					buttonSelected(2, -1, 0, true);
				}
			}
			break;
	}
	
	return false;
}

buttonSelected = function(_bid, _bcolumn, _dir, _anim)
{	
	if(bind)
		return;
		
	bSelected = _bid;
	
	with(obj_menu_textbox)
	{
		if(bid != _bid)
			continue;
			
		if(submenu != obj_menu.submenu)
			continue;
		
		keyboard_string = text;
		keyboard_virtual_show(kbv_type_default, kbv_returnkey_done, kbv_autocapitalize_none, true);
		break;
	}
	
	switch(submenu)
	{
		case SUBMENU_JOIN:
		case SUBMENU_JOIN_MOBILE:
		{
			if(_bid == 1)
			{
				bColumnCount = 5;
			}
			else if(_bid == 2)
			{
				if(_bcolumn >= 2)
					_bcolumn = 0;
					
				bColumnCount = 2;
			}
			break;
		}
	}
		
	var _found = false;
	with(obj_menu_button)
	{		
		if(submenu != obj_menu.submenu)
		{
			image_blend = c_white;
			continue;
		}
		
		if(bcolumn != _bcolumn && bcolumn != -1 && _bcolumn != -1)
		{
			image_blend = c_white;
			continue;
		}
		
		if(bid != _bid)
		{
			image_blend = c_white;
			continue;
		}
		
		if(bcolumn == -1 && _dir != 0 && obj_menu.bSelectedColumn == -1)
		{
			bSelectedColumn = -1;
			obj_menu.bSelectedColumn = bcolumn;
			_bcolumn = bcolumn;
			
			return;
		}
		
		if(_bcolumn == -1 && bcolumn != -1 && bcolumn != 0)
			continue;
		
		if(_found)
			continue;
		
		obj_menu.bSelectedColumn = bcolumn;
		_bcolumn = bcolumn;
		_found = true;
		
		if(object_index != obj_menu_skin)
			image_blend = #910000;
		
		if(_anim)
			offset = 3;
	}
}

buttonPressed = function(_bid, _bcolumn)
{
	if(buttonA)
		return;
		
	if(bind)
		return;
		
	if(bSelected != _bid)
		buttonSelected(_bid, _bcolumn, 0, true);
	
	buttonA = true;
	with(obj_menu_button)
	{
		if(submenu != obj_menu.submenu)
		{
			image_blend = c_white;
			continue;
		}
		
		if(bcolumn != _bcolumn && bcolumn != -1 && _bcolumn != -1)
		{
			image_blend = c_white;
			continue;
		}
		
		if(bid != _bid)
		{
			image_blend = c_white;
			continue;
		}
	
		if(object_index == obj_menu_skin)
		{
			click();
			return;
		}
		
		if(object_index == obj_menu_icon)
		{
			click();
			return;
		}
		
		if(object_index == obj_menu_taunt)
		{
			click();
			return;
		}
		
		if(object_index == obj_menu_pet)
		{
			click();
			return;
		}
		
		if(object_index == obj_menu_togglebutton)
			state = !state;
		break;
	}
	
	audio_play_sound(snd_menu_press, 0, false);
	
	switch(submenu)
	{
		case SUBMENU_NONE:
			switch(_bid)
			{
				case 0:
					changeSubmenu(os_type == os_android ? SUBMENU_JOIN_MOBILE : SUBMENU_JOIN);
					break;
					
				case 1:
					changeSubmenu(SUBMENU_OPTIONSGENERAL);
					buttonSelected(4, -1, 0, false);
					break;
					
				case 2:
					changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
					break;
					
				case 3:
					changeSubmenu(SUBMENU_MECH_SPIN);
					buttonSelected(1, -1, 0, false);
					break;
					
				case 4:
					game_end();
					break;
			}
			
			break;
			
		case SUBMENU_JOIN:
		case SUBMENU_JOIN_MOBILE:
			if(_bid == 0)
			{
				with(obj_menu_textbox)
				{
					if(bid != _bid)
						continue;
						
					if(submenu != obj_menu.submenu)
						continue;
					
					net_join(text);
					break;
				}
				
			}
			else if(_bid == 2)
			{
				if(os_type == os_android)
				{
					if(_bcolumn == 1)
						changeSubmenu(SUBMENU_NONE);
					else
					{
						if(!ServerStart())
						{
							show_message_async("Failed to start internal server!");
							break;
						}
						net_join("127.0.0.1");
					}
				}
				else
					changeSubmenu(SUBMENU_NONE);
			}
			else
			{
				switch(_bcolumn)
				{
					case 0:
						net_join("155.138.243.246");
						break;
						
					case 1:
						net_join("216.238.117.232");
						break;
						
					case 2:
						net_join("185.114.72.187");
						break;
						
					case 3:
						net_join("45.95.203.244");
						break;
						
					case 4:
						net_join("194.36.178.150");
						break;
				}
			}
			break;
			
		case SUBMENU_OPTIONSGENERAL:
			if(_bid == 2)
			{
				obj_config.showPing = findButton("ping").state;
				obj_config.save();
			}
			
			if(_bid == 3)
			{
				obj_config.showFps = findButton("fps").state;
				obj_config.save();
			}
			
			if(_bcolumn == 1)
			{
				if(_bid == 4)
				{
					changeSubmenu(obj_controls.isMobile ? SUBMENU_OPTIONSCONTROLSMOBILE : SUBMENU_OPTIONSCONTROLS);
					
					if(os_type != os_android)
						buttonSelected(8, -1, 0, false);
				}
				
				if(_bid == 5)
					changeSubmenu(SUBMENU_NONE);
			}	
			break;
			
		case SUBMENU_OPTIONSCONTROLS:
			if(_bcolumn == 2)
			{
				if(_bid == 9)
				{
					changeSubmenu(SUBMENU_OPTIONSGENERAL);
					buttonSelected(4, -1, 0, false);
				}
				else if(_bid == 10)
					changeSubmenu(SUBMENU_NONE);
			}
			else
			{
				if(_bid == 10)
					break;
					
				if(_bid == 9)
				{
					bindChanged("left", vk_left);
					bindChanged("right", vk_right);
					bindChanged("up", vk_up);
					bindChanged("down", vk_down);
					bindChanged("jump", ord("Z"));
					bindChanged("special1", ord("X"));
					bindChanged("special2", ord("C"));
					bindChanged("emotion1", ord("A"));
					bindChanged("emotion2", ord("S"));
					bindChanged("emotion3", ord("D"));
					bindChanged("emotion4", ord("W"));
					bindChanged("hidegui", vk_lcontrol);
					bindChanged("playerlist", vk_tab);
					break;
				}
				
				bind = true;
				
				if(_bcolumn == 0)
				{
					switch(_bid)
					{
						case 0: bindBtn = "up"; break;
						case 1: bindBtn = "down"; break;
						case 2: bindBtn = "left"; break;
						case 3: bindBtn = "right"; break;
					}
				}
				else if(_bcolumn == 1)
				{
					switch(_bid)
					{
						case 0: bindBtn = "jump"; break;
						case 1: bindBtn = "special1"; break;
						case 2: bindBtn = "special2"; break;
						case 3: bindBtn = "hidegui"; break;
					}
				}
				else
				{
					switch(_bid)
					{
						case 4: bindBtn = "playerlist"; break;
						case 5: bindBtn = "emotion1"; break;
						case 6: bindBtn = "emotion2"; break;
						case 7: bindBtn = "emotion3"; break;
						case 8: bindBtn = "emotion4"; break;
					}
				}
				
				findTextpanel(bindBtn).text = "press...";
			}
			break;
			
		case SUBMENU_OPTIONSCONTROLSMOBILE:
			if(_bid == 1)
			{
				obj_config.dpadX = 68;
				obj_config.dpadY = 187;
				obj_config.jScale = 1;
				obj_config.jOpacity = 0.6;
				
				obj_config.bAX = 378;
				obj_config.bAY = 221;
				obj_config.bAScale = 1;
				obj_config.bAOpacity = 0.6;
				
				obj_config.bBX = 416;
				obj_config.bBY = 171;
				obj_config.bBScale = 1;
				obj_config.bBOpacity = 0.6;
				
				obj_config.bCX = 452;
				obj_config.bCY = 221;
				obj_config.bCScale = 1;
				obj_config.bCOpacity = 0.6;
				
				obj_config.bDX = 466;
				obj_config.bDY = 48;
				obj_config.bDScale = 1;
				obj_config.bDOpacity = 0.6;
				
				obj_config.bEX = 466;
				obj_config.bEY = 80;
				obj_config.bEScale = 1;
				obj_config.bEOpacity = 0.6;
				
				obj_config.bFX = 466;
				obj_config.bFY = 112;
				obj_config.bFScale = 1;
				obj_config.bFOpacity = 0.6;
				
				obj_config.bWX = 466;
				obj_config.bWY = 112 + 32;
				obj_config.bWScale = 1;
				obj_config.bWOpacity = 0.6;
				
				obj_config.bGX = 23;
				obj_config.bGY = 36+15;
				obj_config.bGScale = 1;
				obj_config.bGOpacity = 0.6;
				obj_config.save();
			}
			else if(_bid == 2)
				changeSubmenu(SUBMENU_OPTIONSGENERAL);
			
			break;
			
		case SUBMENU_OPTIONSBACK:
			if(_bid == 1)
			{
				changeSubmenu(SUBMENU_OPTIONSGENERAL);
				buttonSelected(4, -1, 0, false);
			}
			else if(_bid == 2)
			{
				changeSubmenu(obj_controls.isMobile ? SUBMENU_OPTIONSCONTROLSMOBILE : SUBMENU_OPTIONSCONTROLS);
				
				if(os_type != os_android)
					buttonSelected(8, -1, 0, false);
			}
			else
				changeSubmenu(SUBMENU_NONE);
			break;
			
		case SUBMENU_ABOUT_CREDITS:
			if(_bid == 1)
				changeSubmenu(SUBMENU_NONE);
			else if(_bid == 2)
			{
				changeSubmenu(SUBMENU_CHAR_TAILS);
				buttonSelected(1, 0, -1, false);
			}
			else if(_bid == 3)
			{
				changeSubmenu(SUBMENU_MECH_SPIN);
				buttonSelected(1, 0, -1, false);
			}
			break;
			
		case SUBMENU_ABOUT_BACK:
			if(_bid == 0)
				changeSubmenu(SUBMENU_NONE);
			if(_bid == 1)
				changeSubmenu(SUBMENU_ABOUT_CREDITS);
			else if(_bid == 2)
			{
				changeSubmenu(SUBMENU_CHAR_TAILS);
				buttonSelected(1, 0, -1, false);
			}
			else if(_bid == 3)
			{
				changeSubmenu(SUBMENU_MECH_SPIN);
				buttonSelected(1, 0, -1, false);
			}
			break;
		
		case SUBMENU_MECH_SPIN:
		case SUBMENU_MECH_STEAL:
		case SUBMENU_MECH_HIT:
		case SUBMENU_MECH_PAR:
		case SUBMENU_MECH_RINGS:
		case SUBMENU_MECH_REB:
		case SUBMENU_MECH_REDRINGS:
		case SUBMENU_MECH_DEMON:
		case SUBMENU_MECH_SUDDEN:
		case SUBMENU_MECH_ESCAPE:
		case SUBMENU_MECH_DIFF:
			if(_bid == 2)
			{
				changeSubmenu(SUBMENU_CHAR_TAILS);
				buttonSelected(1, 0, -1, false);
			}
			else if(_bid == 3)
				changeSubmenu(SUBMENU_ABOUT_CREDITS);
			else if(_bid == 4)
				changeSubmenu(SUBMENU_NONE);
				
			if(_bcolumn != 1)
				break;
		
			if(_bid == 1)
			{
				if(submenu + 1 > SUBMENU_MECH_DIFF)
				{
					changeSubmenu(SUBMENU_MECH_SPIN);
					break;
				}
				
				changeSubmenu(submenu + 1);
			}
			else
			{
				if(submenu - 1 < SUBMENU_MECH_SPIN)
				{
					changeSubmenu(SUBMENU_MECH_DIFF);
					break;
				}	
				
				changeSubmenu(submenu - 1);
			}
			
			with(obj_menu_gif)
				image_index = 0;
			
			break;
		
		case SUBMENU_CHAR_TAILS:
		case SUBMENU_CHAR_KNUX:
		case SUBMENU_CHAR_EGG:
		case SUBMENU_CHAR_AMY:
		case SUBMENU_CHAR_SALLY:
		case SUBMENU_CHAR_CREAM:
		case SUBMENU_CHAR_EXE:
		case SUBMENU_CHAR_CHAOS:
		case SUBMENU_CHAR_EXETIOR:
		case SUBMENU_CHAR_EXELLER:
			if(_bid == 2)
			{
				changeSubmenu(SUBMENU_MECH_SPIN);
				buttonSelected(1, 0, -1, false);
			}
			else if(_bid == 3)
				changeSubmenu(SUBMENU_ABOUT_CREDITS);
			else if(_bid == 4)
				changeSubmenu(SUBMENU_NONE);
				
			if(_bcolumn != 1)
				break;
		
			if(_bid == 1)
			{
				if(submenu + 1 > SUBMENU_CHAR_EXELLER)
				{
					changeSubmenu(SUBMENU_CHAR_TAILS);
					break;
				}
				
				changeSubmenu(submenu + 1);
			}
			else
			{
				if(submenu - 1 < SUBMENU_CHAR_TAILS)
				{
					changeSubmenu(SUBMENU_CHAR_EXELLER);
					break;
				}	
				
				changeSubmenu(submenu - 1);
			}
			
			break;
			
		case SUBMENU_EXTRA_ACHIVEMENTS:
			switch(_bid)
			{
				case 1:
					changeSubmenu(SUBMENU_EXTRA_TAILS);
					buttonSelected(3, -1, 0, false);
					break;
					
				case 2:
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(3, -1, 0, false);
					break;
					
				case 3:
					changeSubmenu(SUBMENU_EXTRA_PENIS);
					buttonSelected(2, -1, 0, false);
					break;
					
				case 4:
					changeSubmenu(SUBMENU_EXTRA_TAUNT);
					buttonSelected(2, -1, 0, false);
					break;
					
				case 5:
					changeSubmenu(SUBMENU_NONE);
					break;
			}
			break;
			
		case SUBMENU_EXTRA_BACK:
			switch(_bid)
			{
				case 0:
					changeSubmenu(SUBMENU_NONE);
					break;
					
				case 1:
					changeSubmenu(SUBMENU_EXTRA_TAILS);
					buttonSelected(3, -1, 0, false);
					break;
					
				case 2:
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(3, -1, 0, false);
					break;
					
				case 3:
					changeSubmenu(SUBMENU_EXTRA_PENIS);
					buttonSelected(2, -1, 0, false);
					break;
					
				case 4:
					changeSubmenu(SUBMENU_EXTRA_TAUNT);
					buttonSelected(2, -1, 0, false);
					break;
					
				case 5:
					changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
					buttonSelected(1, 0, -1, false);
					break;
			}
			return true;
			
		case SUBMENU_EXTRA_TAILS:
		case SUBMENU_EXTRA_KNUX:
		case SUBMENU_EXTRA_EGG:
		case SUBMENU_EXTRA_AMY:
		case SUBMENU_EXTRA_SALLY:
		case SUBMENU_EXTRA_CREAM:
		case SUBMENU_EXTRA_EXE:
		case SUBMENU_EXTRA_CHAOS:
		case SUBMENU_EXTRA_EXETIOR:
		case SUBMENU_EXTRA_EXELLER:
			if(_bcolumn == 5)
			{
				switch(_bid)
				{
					case 0:
						changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
						buttonSelected(0, -1, 0, false);
						break;
						
					case 1:
						changeSubmenu(SUBMENU_EXTRA_SKINS1);
						buttonSelected(3, -1, 0, false);
						break;
						
					case 2:
						changeSubmenu(SUBMENU_EXTRA_PENIS);
						buttonSelected(2, -1, 0, false);
						break;
						
					case 3:
						changeSubmenu(SUBMENU_EXTRA_TAUNT);
						buttonSelected(2, -1, 0, false);
						break;
						
					case 4:
						changeSubmenu(SUBMENU_NONE);
						break;
				}
			}
			
			if(_bcolumn != 4)
				break;
		
			if(_bid == 1)
			{
				if(submenu + 1 > SUBMENU_EXTRA_EXELLER)
				{
					changeSubmenu(SUBMENU_EXTRA_TAILS);
					buttonSelected(0, -1, 0, false);
					break;
				}
				
				changeSubmenu(submenu + 1);
			}
			else
			{
				if(submenu - 1 < SUBMENU_EXTRA_TAILS)
				{
					changeSubmenu(SUBMENU_EXTRA_EXELLER);
					break;
				}	
				
				changeSubmenu(submenu - 1);
			}
			break;
			
		case SUBMENU_EXTRA_SKINS1:
			if(_bcolumn == 5)
			{
				switch(_bid)
				{
					case 0:
						changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
						buttonSelected(1, 0, -1, false);
						return true;
						
					case 1:
						changeSubmenu(SUBMENU_EXTRA_TAILS);
						buttonSelected(3, -1, 0, false);
						break;
						
					case 2:
						changeSubmenu(SUBMENU_EXTRA_PENIS);
						buttonSelected(2, -1, 0, false);
						break;
						
					case 3:
						changeSubmenu(SUBMENU_EXTRA_TAUNT);
						buttonSelected(2, -1, 0, false);
						break;
						
					case 4:
						changeSubmenu(SUBMENU_NONE);
						break;
				}
			}
			
			if(_bcolumn != 4)
				break;
		
			if(_bid == 4)
			{
				changeSubmenu(SUBMENU_EXTRA_SKINS2);
			}
			else
			{
				changeSubmenu(SUBMENU_EXTRA_SKINS3);
			}
			break;
		
		case SUBMENU_EXTRA_SKINS2:
			if(_bcolumn == 5)
			{
				switch(_bid)
				{
					case 0:
						changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
						buttonSelected(1, 0, -1, false);
						return true;
						
					case 1:
						changeSubmenu(SUBMENU_EXTRA_TAILS);
						buttonSelected(3, -1, 0, false);
						break;
						
					case 2:
						changeSubmenu(SUBMENU_EXTRA_PENIS);
						buttonSelected(2, -1, 0, false);
						break;
						
					case 3:
						changeSubmenu(SUBMENU_EXTRA_TAUNT);
						buttonSelected(2, -1, 0, false);
						break;
						
					case 4:
						changeSubmenu(SUBMENU_NONE);
						break;
				}
			}
			
			if(_bcolumn != 4)
				break;
		
			if(_bid == 4)
				changeSubmenu(SUBMENU_EXTRA_SKINS1);
			else
				changeSubmenu(SUBMENU_EXTRA_SKINS3);
			break;
			
		case SUBMENU_EXTRA_SKINS3:
			if(_bcolumn == 5)
			{
				switch(_bid)
				{
					case 0:
						changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
						buttonSelected(1, 0, -1, false);
						return true;
						
					case 1:
						changeSubmenu(SUBMENU_EXTRA_TAILS);
						buttonSelected(3, -1, 0, false);
						break;
						
					case 2:
						changeSubmenu(SUBMENU_EXTRA_PENIS);
						buttonSelected(2, -1, 0, false);
						break;
						
					case 3:
						changeSubmenu(SUBMENU_EXTRA_TAUNT);
						buttonSelected(2, -1, 0, false);
						break;
						
					case 4:
						changeSubmenu(SUBMENU_NONE);
						break;
				}
			}
			
			if(_bcolumn != 4)
				break;
		
			if(_bid == 4)
			{
				changeSubmenu(SUBMENU_EXTRA_SKINS1);
			}
			else
			{
				changeSubmenu(SUBMENU_EXTRA_SKINS2);
			}
			break;
			
		case SUBMENU_EXTRA_PENIS:
		{
			if(_bcolumn != 5)
				break;
				
			switch(_bid)
			{
				case 0:
					changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
					buttonSelected(1, 0, -1, false);
					break;
					
				case 1:
					changeSubmenu(SUBMENU_EXTRA_TAILS);
					buttonSelected(3, -1, 0, false);
					break;
					
				case 2:
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(3, -1, 0, false);
					return true;
					
				case 3:
					changeSubmenu(SUBMENU_EXTRA_TAUNT);
					buttonSelected(2, -1, 0, false);
					break;
					
				case 4:
					changeSubmenu(SUBMENU_NONE);
					break;
			}
			return true;
		}
			
		case SUBMENU_EXTRA_TAUNT:
		{
			if(_bcolumn != 5)
				break;
				
			switch(_bid)
			{
				case 3:
					changeSubmenu(SUBMENU_EXTRA_ACHIVEMENTS);
					buttonSelected(1, 0, -1, false);
					break;
					
				case 4:
					changeSubmenu(SUBMENU_EXTRA_TAILS);
					buttonSelected(3, -1, 0, false);
					break;
					
				case 5:
					changeSubmenu(SUBMENU_EXTRA_SKINS1);
					buttonSelected(3, -1, 0, false);
					return true;
					
				case 6:
					changeSubmenu(SUBMENU_EXTRA_PENIS);
					buttonSelected(2, -1, 0, false);
					break;
					
				case 7:
					changeSubmenu(SUBMENU_NONE);
					break;
			}
			break;
		}
	}
}

changeSubmenu = function(_menu)
{
	submenu = _menu;
	
	layer_set_visible(layer_get_id("Main"), false);
	layer_set_visible(layer_get_id("Main2"), false);
	layer_set_visible(layer_get_id("Main3"), false);
	layer_set_visible(layer_get_id("JoinGame"), false);
	layer_set_visible(layer_get_id("JoinGameMobile"), false);
	layer_set_visible(layer_get_id("OptionsGeneral"), false);
	layer_set_visible(layer_get_id("OptionsControls"), false);
	layer_set_visible(layer_get_id("OptionsControlsMobile"), false);
	layer_set_visible(layer_get_id("OptionsBack"), false);
	layer_set_visible(layer_get_id("AboutSpin"), false);
	layer_set_visible(layer_get_id("AboutHit"), false);
	layer_set_visible(layer_get_id("AboutPar"), false);
	layer_set_visible(layer_get_id("AboutReb"), false);
	layer_set_visible(layer_get_id("AboutSteal"), false);
	layer_set_visible(layer_get_id("AboutRings"), false);
	layer_set_visible(layer_get_id("AboutRedRings"), false);
	layer_set_visible(layer_get_id("AboutDemon"), false);
	layer_set_visible(layer_get_id("AboutSudden"), false);
	layer_set_visible(layer_get_id("AboutEscape"), false);
	layer_set_visible(layer_get_id("AboutDiff"), false);
	layer_set_visible(layer_get_id("AboutCredits"), false);
	layer_set_visible(layer_get_id("AboutCreditsText"), false);
	layer_set_visible(layer_get_id("AboutBack"), false);
	layer_set_visible(layer_get_id("AboutTails"), false);
	layer_set_visible(layer_get_id("AboutKnux"), false);
	layer_set_visible(layer_get_id("AboutEgg"), false);
	layer_set_visible(layer_get_id("AboutAmy"), false);
	layer_set_visible(layer_get_id("AboutCream"), false);
	layer_set_visible(layer_get_id("AboutSally"), false);
	layer_set_visible(layer_get_id("AboutExe"), false);
	layer_set_visible(layer_get_id("AboutChaos"), false);
	layer_set_visible(layer_get_id("AboutExetior"), false);
	layer_set_visible(layer_get_id("AboutExeller"), false);
	layer_set_visible(layer_get_id("AboutCharacter"), false);
	layer_set_visible(layer_get_id("ExtraAchivements"), false);
	layer_set_visible(layer_get_id("ExtraAchivementsList"), false);
	layer_set_visible(layer_get_id("Achivements"), false);
	layer_set_visible(layer_get_id("ExtraTails"), false);
	layer_set_visible(layer_get_id("ExtraKnux"), false);
	layer_set_visible(layer_get_id("ExtraEgg"), false);
	layer_set_visible(layer_get_id("ExtraAmy"), false);
	layer_set_visible(layer_get_id("ExtraCream"), false);
	layer_set_visible(layer_get_id("ExtraSally"), false);
	layer_set_visible(layer_get_id("ExtraExe"), false);
	layer_set_visible(layer_get_id("ExtraChaos"), false);
	layer_set_visible(layer_get_id("ExtraExetior"), false);
	layer_set_visible(layer_get_id("ExtraExeller"), false);
	layer_set_visible(layer_get_id("ExtraBack"), false);
	layer_set_visible(layer_get_id("ExtraSkins1"), false);
	layer_set_visible(layer_get_id("ExtraSkins2"), false);
	layer_set_visible(layer_get_id("ExtraSkins3"), false);
	layer_set_visible(layer_get_id("ExtraMoney"), false);
	layer_set_visible(layer_get_id("ExtraPenis"), false);
	layer_set_visible(layer_get_id("ExtraTaunts"), false);
	
	switch(submenu)
	{
		case SUBMENU_NONE:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 0);
			bCount = 5;
			bColumnCount = 0;
			scheme = false;
			
			layer_set_visible(layer_get_id("Main"), true);
			layer_set_visible(layer_get_id("Main2"), true);
			layer_set_visible(layer_get_id("Main3"), true);
			break;
			
		case SUBMENU_JOIN:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 1);
			bCount = 3;
			bColumnCount = 5;
			scheme = true;
			layer_set_visible(layer_get_id("JoinGame"), true);
			break;
			
		case SUBMENU_JOIN_MOBILE:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 1);
			bCount = 3;
			bColumnCount = 5;
			scheme = true;
			layer_set_visible(layer_get_id("JoinGameMobile"), true);
			break;
		
		case SUBMENU_OPTIONSGENERAL:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 2);
			bCount = 5;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("OptionsGeneral"), true);
			break;
			
		case SUBMENU_OPTIONSCONTROLS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 2);
			bCount = 11;
			bColumnCount = 2;
			scheme = true;
			layer_set_visible(layer_get_id("OptionsControls"), true);
			break;
			
		case SUBMENU_OPTIONSCONTROLSMOBILE:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 3);
			bCount = 3;
			bColumnCount = 0;
			scheme = false;
			layer_set_visible(layer_get_id("OptionsControlsMobile"), true);
			break;
			
		case SUBMENU_OPTIONSBACK:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 2);
			bCount = 1;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("OptionsBack"), true);
			break;
			
		case SUBMENU_MECH_SPIN:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutSpin"), true);
			break;
			
		case SUBMENU_MECH_HIT:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutHit"), true);
			break;
			
		case SUBMENU_MECH_PAR:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutPar"), true);
			break;
			
		case SUBMENU_MECH_REB:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutReb"), true);
			break;
					
		case SUBMENU_MECH_STEAL:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutSteal"), true);
			break;
					
		case SUBMENU_MECH_RINGS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutRings"), true);
			break;
				
		case SUBMENU_MECH_REDRINGS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutRedRings"), true);
			break;
			
		case SUBMENU_MECH_DEMON:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutDemon"), true);
			break;
			
		case SUBMENU_MECH_SUDDEN:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutSudden"), true);
			break;
			
		case SUBMENU_MECH_ESCAPE:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutEscape"), true);
			break;
			
		case SUBMENU_MECH_DIFF:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutDiff"), true);
			break;
			
		case SUBMENU_CHAR_TAILS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutTails"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_tails;
			break;
			
		case SUBMENU_CHAR_KNUX:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutKnux"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_knux;
			break;
			
		case SUBMENU_CHAR_EGG:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutEgg"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_egg;
			break;
			
		case SUBMENU_CHAR_AMY:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutAmy"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_amy;
			break;
			
		case SUBMENU_CHAR_CREAM:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutCream"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_cream;
			break;
			
		case SUBMENU_CHAR_SALLY:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutSally"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_sally;
			break;
			
		case SUBMENU_CHAR_EXE:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutExe"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_exe;
			break;
			
		case SUBMENU_CHAR_CHAOS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutChaos"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_chaos;
			break;
			
		case SUBMENU_CHAR_EXETIOR:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutExetior"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_exetior;
			break;
			
		case SUBMENU_CHAR_EXELLER:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 4);
			bCount = 2;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutExeller"), true);
			layer_set_visible(layer_get_id("AboutCharacter"), true);
			obj_menu_character.sprite_index = spr_menu_exeller;
			break;
			
		case SUBMENU_ABOUT_CREDITS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 5);
			bCount = 1;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutCredits"), true);
			layer_set_visible(layer_get_id("AboutCreditsText"), true);
			obj_menu_credits.y = 196;
			keyboard_string = "";
			break;
			
		case SUBMENU_ABOUT_BACK:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 0);
			bCount = 1;
			bColumnCount = 0;
			scheme = true;
			layer_set_visible(layer_get_id("AboutBack"), true);
			obj_menu_credits.y = 196;
			break;
			
		case SUBMENU_EXTRA_ACHIVEMENTS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 7);
			bCount = 1;
			bColumnCount = 0;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraAchivements"), true);
			layer_set_visible(layer_get_id("ExtraAchivementsList"), true);
			break;
			
		case SUBMENU_EXTRA_TAILS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraTails"), true);
			break;
			
		case SUBMENU_EXTRA_KNUX:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraKnux"), true);
			break;
			
		case SUBMENU_EXTRA_EGG:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraEgg"), true);
			break;
			
		case SUBMENU_EXTRA_AMY:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraAmy"), true);
			break;
			
		case SUBMENU_EXTRA_CREAM:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraCream"), true);
			break;
			
		case SUBMENU_EXTRA_SALLY:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraSally"), true);
			break;
			
		case SUBMENU_EXTRA_EXE:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraExe"), true);
			break;
			
		case SUBMENU_EXTRA_CHAOS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraChaos"), true);
			break;
			
		case SUBMENU_EXTRA_EXETIOR:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraExetior"), true);
			break;
			
		case SUBMENU_EXTRA_EXELLER:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraExeller"), true);
			break;

		case SUBMENU_EXTRA_SKINS1:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 5;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraSkins1"), true);
			break;
			
		case SUBMENU_EXTRA_SKINS2:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 4;
			bColumnCount = 5;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraSkins2"), true);
			break;
			
		case SUBMENU_EXTRA_SKINS3:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 3;
			bColumnCount = 5;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraSkins3"), true);
			break;
			
		case SUBMENU_EXTRA_BACK:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 6);
			bCount = 1;
			bColumnCount = 0;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraBack"), true);
			break;
			
		case SUBMENU_EXTRA_PENIS:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 7);
			bCount = 3;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraPenis"), true);
			break;
			
		case SUBMENU_EXTRA_TAUNT:
			layer_background_sprite(bars, spr_menu_bars);
			layer_background_index(bars, 7);
			bCount = 3;
			bColumnCount = 4;
			scheme = true;
			
			layer_set_visible(layer_get_id("Achivements"), true);
			layer_set_visible(layer_get_id("ExtraMoney"), true);
			layer_set_visible(layer_get_id("ExtraTaunts"), true);
			break;
	}
	
	buttonSelected(0, -1, 0, false);
}

textChanged = function(_bid, _text)
{
	if(submenu == SUBMENU_JOIN || submenu == SUBMENU_JOIN_MOBILE)
	{
		obj_config.ip = _text;
		obj_config.save();
	}
	
	if(submenu == SUBMENU_OPTIONSGENERAL)
	{
		global.nickname = scr_nickname_validate(_text);
		obj_config.save();
	}
}

bindChanged = function (_bid, _key)
{
	var btn = findTextpanel(_bid);
	btn.text = scr_controls_keycode_to_key(_key);
	
	switch(_bid)
	{
		case "up": global.KeyUp = _key; break;
		case "down": global.KeyDown = _key; break;
		case "left": global.KeyLeft = _key; break;
		case "right": global.KeyRight = _key; break;
		case "jump": global.KeyA = _key; break;
		case "special1": global.KeyB = _key; break;
		case "special2": global.KeyC = _key; break;
		case "hidegui": global.KeyHide = _key; break;
		case "playerlist": global.KeyPList = _key; break;
		case "emotion1": global.KeyEm1 = _key; break;
		case "emotion2": global.KeyEm2 = _key; break;
		case "emotion3": global.KeyEm3 = _key; break;
		case "emotion4": global.KeyIdle = _key; break;
	}
	
	obj_config.save();
}

sliderChanged = function(_value)
{
	if(mobSelectedButton == 0)
	{
		obj_controls.buttonSetProp(0, obj_menu_mobiledpad.scale, _value);
	}
	else if (mobSelectedButton <= 3)
	{
		with(obj_menu_mobilebutton)
		{
			if(bid == obj_menu.mobSelectedButton)
				obj_controls.buttonSetProp(bid, scale, _value);
		}
	}
	else
	{
		with(obj_menu_mobilebutton2)
		{
			if(bid == obj_menu.mobSelectedButton)
				obj_controls.buttonSetProp(bid, scale, _value);
		}
	}
}

alarm[0] = 1;