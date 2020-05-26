## COCBot
Revisiting an old set of game automation scripts that automate resource acquisition in a specific mobile/computer game. 2 rewrites were accomplished: A hybrid Java/AutoHotKey configuration executing compiled AHK files from the jvm, &amp; a fully AutoHotKey version with a few basic hotkey functionalities and simple UI that has been compiled into an executable. 

It almost exclusively sends keyboard input to the target window by name, so it and the application can be run in the background.

This bot has been adjusted for a few recent game updates at the time of this repo's posting but will not be maintained going forward. Anyone forking this repo is encouraged to figure out text/image recognition to add an intelligence factor to the battle-finding ability, which will make this bot viable in most stages of the game.

# Notes

CocBotDeliverable/ has 2 executables with the settings i commonly ran with, as well as a required image for the ui.

java/ contains the makefile to run the java version with.

ahk/ contains the ahk that the java version depends on, in addition to the AHK file of the fully AutoHotKey version. This AHK source is the most interesting part of this repo. 
