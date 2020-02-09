#pragma semicolon 1

#include <sourcemod>
#include <tf2>

#define PLUGIN_VERSION            "1.0.0"
#define PLUGIN_VERSION_CVAR       "sm_4chquoter_version"

public Plugin myinfo = 
{
	name = "[TF2] Imageboard Green Text",
	author = "2010kohtep",
	description = "Print quote-styled text in global chat.",
	version = PLUGIN_VERSION,
	url = "https://github.com/2010kohtep"
};

ConVar g4chVersion;

public void OnPluginStart()
{	
	AddCommandListener(OnSay, "say");
	
	g4chVersion = CreateConVar(PLUGIN_VERSION_CVAR, PLUGIN_VERSION, "Plugin version.", FCVAR_SPONLY | FCVAR_NOTIFY | FCVAR_PRINTABLEONLY);
}

public Action OnSay(client, const String:command[], argc)
{
	if(!client || client > MaxClients || !IsClientInGame(client)) 
		return Plugin_Continue;

	decl String:text[128];
	
	GetCmdArgString(text, sizeof(text));
	StripQuotes(text);
	
	if (text[0] == '>')
	{
		decl String:output[256];

		switch (GetClientTeam(client))
		{
			case TFTeam_Blue:
			{
				Format(output, sizeof(output), "\x0799CCFF%N\x01 : \x05%s", client, text);
			}
			
			case TFTeam_Red:
			{
				Format(output, sizeof(output), "\x07FF4040%N\x01 : \x05%s", client, text);
			}
			
			default:
			{
				Format(output, sizeof(output), "\x07CCCCCC%N\x01 : \x05%s", client, text);
			}
		}
		
		PrintToChatAll(output);

		return Plugin_Handled;
	}
	
	return Plugin_Continue;
}