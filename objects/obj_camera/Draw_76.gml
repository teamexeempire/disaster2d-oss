switch(global.cameraMode)
{
	case 0: //follow
	{	
		if(instance_exists(global.player))
		{
			if(!global.player.isGrounded)
			{
				var yy = floor(global.player.y) - 135;
				
				dist = y - yy;
			
				x = floor(global.player.x) - 240;
				if(abs(dist) > 32)
				{
					dist = 32 * sign(dist);
					y = floor(global.player.y) - 135 + dist;
				}
			}
			else
			{
				if(global.player.isLookingDown)
				{
					look_timer++;
				
					if(look_timer > 60 * 1.5 && dist < 100)
						dist += 2;
				}
				else if(global.player.isLookingUp)
				{
					look_timer++;
				
					if(look_timer > 60 * 1.5 && dist > -100)
						dist -= 2;
				} 
				else look_timer = 0;
			
				x = floor(global.player.x) - 240;
				y = floor(global.player.y) - 135 + dist;
			}
		}
		break;
	}
	
	case 2: //spectate
	{
		if(spectatingObj == noone)
		{
			var ind = 0;
			for (var k = ds_map_find_first(obj_netclient.players); !is_undefined(k); k = ds_map_find_next(obj_netclient.players, k))
			{
				if(ind == spectatingInd)
				{
					with(obj_player_puppet)
					{
						if(master_id == k)
						{
							if(obj_netclient.exeId == k)
								break;
								
							if(isDemonized || state == DEAD)
								break;
							
							obj_camera.spectatingObj = self;
						}
					}
					
					if(spectatingObj == noone)
					{
						spectatingInd++;
						if(spectatingInd > ds_map_size(obj_netclient.players)-1)
							spectatingInd = 0;
					}
				}
				
				ind++;
			}
		}
		
		if(spectatingObj != noone)
		{
			if(distance_to_object(spectatingObj) > 10)
			{
				x = lerp(x, floor(spectatingObj.x) - 240, 0.5);
				y = lerp(y, floor(spectatingObj.y) - 135, 0.5);
			}
			else
			{
				x = floor(spectatingObj.x) - 240;
				y = floor(spectatingObj.y) - 135;
			}
		}
		
		if(!locked && keyboard_check_pressed(vk_anykey))
		{
			spectatingObj = noone;
			spectatingInd++;
			
			if(spectatingInd > ds_map_size(obj_netclient.players)-1)
				spectatingInd = 0;
		}
		break;
	}
	
	case 3: //fade
	{
		if(prevMode != 3)
			alarm[1] = 60 * 3;
		break;
	}
	
	case 4:
	{
		if(target == noone)
			break;
			
		x = floor(target.x) - 240;
		y = floor(target.y) - 135;
		break;
	}
}

if(global.cameraMode != prevMode)
	prevMode = global.cameraMode;

// Slowly move camera back
if(look_timer == 0)
	repeat(2)
	{
		dist -= sign(dist);
		if(dist == 0)
			break;
	}

//Screen shake
if(shake) 
{ 
   shakeTime -= 1; 
   x += choose(-shakeMagnitude, shakeMagnitude); 
   y += choose(-shakeMagnitude, shakeMagnitude); 

   if(shakeTime <= 0) 
   { 
      shakeMagnitude -= shakeFade; 

      if(shakeMagnitude <= 0) 
      { 
         shake = false; 
      } 
   } 
}


x = clamp(x, 0, room_width - 480);
y = clamp(y, 0, room_height - 270);

camera_set_view_pos(view_camera[0], x, y);
audio_listener_orientation(0, 0, 1, 0, -1, 0);
audio_listener_position(x+240, y+135, 0);