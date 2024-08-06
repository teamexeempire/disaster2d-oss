function scr_nickname_validate(str)
{
	var str2 = str;
	var pattern = [ "\\", "/", "@", "|", "№", "`", "~", "&", " " ];
	
	for(var i = 0; i < array_length(pattern); i++)
		str2 = string_replace_all(str2, pattern[i], "");
		
	if(string_length(str2) <= 0 || str2 == "")
		return $"/player~ \\{irandom(9999)}";
		
	return str;	
}