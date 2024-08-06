var ch = char;

if(char > CHARACTER_SALLY)
{
	ch -= CHARACTER_SALLY + 1;
	ch += PALETTE_EXE;
}
else if(demon)
	ch += PALETTE_DEMON;

ind++;
if(ind >= array_length(global.palettes[? ch]))
	ind = -1;