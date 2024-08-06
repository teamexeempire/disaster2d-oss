function scr_camera_shake(time, magnitude, fade)
{
   with (obj_camera)
   {
      shake = true;
      shakeTime = time;
      shakeMagnitude = magnitude;
      shakeFade = fade;
   }
}