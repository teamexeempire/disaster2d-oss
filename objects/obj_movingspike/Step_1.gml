var dist = distance_to_object(obj_camera);
visible = dist < 530;

if(image_index > 0 && image_index < 5)
	mask_index = spr_spike;
else
	mask_index = -1;