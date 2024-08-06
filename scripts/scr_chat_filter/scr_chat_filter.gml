global.chatFilter = [
	"nigger",
	"nigga",
	"niggas",
	"nigg",
	"faggot",
	"tranny",
	"экзюшка",
	"эгусик",
	"эггусик",
	"эмичка",
	"кримка",
	"салька",
	"наксик",
	"хохол",
	"москаль"
];

function scr_chat_filter(str)
{
	finalStr = str;
	
	for(var i = 0; i < array_length(global.chatFilter); i++)
		finalStr = string_replace_all(finalStr, global.chatFilter[i], string_repeat("*", string_length(global.chatFilter[i])));
	
	finalStr = string_replace_all(finalStr, "\r", "");
	finalStr = string_replace_all(finalStr, "\t", "");
	finalStr = string_replace_all(finalStr, "\n", "");
	
	return finalStr;
}