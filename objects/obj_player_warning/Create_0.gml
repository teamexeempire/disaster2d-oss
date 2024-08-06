fade = 0;
moved = false;
text = choose(
	"the fear of leaving the shelter has shackled you",
	"your legs refuse to move...",
	"you try to be careful about your movements",
	"the fear of unknown disarms you",
	"your limbs are cramping with fear...",
	"you feel way too immobilized"
);
textLen = string_length(text);
textWidth = textLen * 8;
timer = 0;

terraria = irandom_range(0, 50) == 20;
terraText = choose(
	"You feel an evil presence watching you...",
	"Impending doom approaches...",
	"You feel vibrations from deep below...",
	"The air is getting colder around you...",
	"This is going to be a terrible night..."
);

audio_sound_gain(global.music, 0, 2000); 
	
if(terraria)
	audio_play_sound(snd_bos, 0, true);
else
	audio_play_sound(snd_fnac, 0, false);