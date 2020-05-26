package ahk;

import java.lang.RuntimeException;

import logger.Logger;

public class AHK {
	private static final Logger logger = new Logger(AHK.class);

	private static String AHK_EXECUTABLE_BASE_FOLDER = "/mnt/c/Users/runya/Desktop/Code/BluestacksCOCAutomationProject/src/ahk/exe/";

	public static void runExecByName(String exeName){
		runExecByName(exeName, "");
	}

	public static void runExecByName(String exeName, String arg){
		try{
			Runtime run = Runtime.getRuntime(); //should this runtime object be a global var? idk cost of making it so much
			//for now let's assume these don't run concurrently. one AHK script at a time.
			Process proc = run.exec(AHK_EXECUTABLE_BASE_FOLDER + exeName + " " + arg);
			proc.waitFor();
		}catch(Exception e){
			logger.error("An exception was caught while running AHK script \"" + exeName + "\": " + e.getMessage());
			throw new RuntimeException();
		}
	}

}