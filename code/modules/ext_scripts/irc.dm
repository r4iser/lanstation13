#define IRC_FLAG_GENERAL "nudges"
#define IRC_FLAG_ADMINHELP "ahelps"

/proc/send2irc(var/channel, var/msg)
	if(config.use_irc_bot)
		var/a=" --key=\"[config.comms_password]\""
		a +=" --host=\"[config.irc_bot_host]\""
		a += " --channel=\"[channel]\""
		msg = replacetext(msg,"\"","\\\"")
		ext_python("ircbot_message.py", "[a] [msg]")
	return

/proc/send2mainirc(var/msg)
	send2irc(IRC_FLAG_GENERAL,msg)

/proc/send2adminirc(var/msg)
	send2irc(IRC_FLAG_ADMINHELP,msg)
