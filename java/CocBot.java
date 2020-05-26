import java.lang.Runtime;
import java.lang.RuntimeException;
import java.io.IOException;
import java.io.File;
import java.lang.Thread;
import java.util.ArrayList;

import logger.Logger;
import ahk.AHK;
import io.IO;
import io.AccountInfo;

public class CocBot {
	private static final Logger logger = new Logger(CocBot.class);
	
	private static final String ACCOUNT_INFO_PATH = "/mnt/c/Users/runya/Desktop/Code/BluestacksCOCAutomationProject/src/resources/credentials.txt";
	private static final String BLUESTACKS_BASH_LOCATION = "/mnt/c/ProgramData/BlueStacks/Client/Bluestacks.exe";
	private static final long BLUESTACKS_STARTUP_DELAY = 120000;

	private static final long ACCOUNT_TIME_BEFORE_SWITCH = 10800000l; //THREE hour rotations
	private static final boolean ACCOUNT_SWITCHING_ENABLED = true;
	private static final int ACC_MIN_RANGE = 1;  
	private static final int ACC_HIGH_RANGE = 4;

	public static void main(String[] args){
		// init();
		// launchCOC();
		simpleLoop();
		// trainBarch();
		// test();
	}

	private static void init(){
		Runtime run = Runtime.getRuntime();
		try{
			long startTime = System.currentTimeMillis();
			logger.info("Starting bluestacks at time " + startTime);
			Process proc = run.exec(BLUESTACKS_BASH_LOCATION);
			while(System.currentTimeMillis() - startTime < BLUESTACKS_STARTUP_DELAY){
				logger.info("Waited " + (System.currentTimeMillis() - startTime) + " of " + BLUESTACKS_STARTUP_DELAY + ".");
				Thread.sleep(10000);
			}
			logger.info("Bluestacks PROBABLY started after the grace period.");
		}catch(Exception e){
			logger.error("Caught an exception while intializing Bluestacks");
			throw new RuntimeException("Caught an exception while initializing BlueStacks", e);
		}
	}

	private static void launchCOC() {
		AHK.runExecByName("FullscreenBluestacks.exe"); 
		AHK.runExecByName("LaunchCOCFromBluestacksHome.exe");
		AHK.runExecByName("FullscreenBluestacks.exe"); //need to do second time bc can't fullscreen via f11 from home
	}

	private static void simpleLoop() {
		ArrayList<AccountInfo> accounts = IO.readAccountInfo(ACCOUNT_INFO_PATH);
		int curAcct = ACC_MIN_RANGE; 
		long curAcctStartingTime = System.currentTimeMillis();
		long iters = 1;
		for(;;){
			String campSizeForCurrentAccount = accounts.get(curAcct - 1).getClashInfo().getCampSize() + "";
			AHK.runExecByName("5SecSleep.exe");
			AHK.runExecByName("Retrain.exe", campSizeForCurrentAccount);
			AHK.runExecByName("5SecSleep.exe");
			AHK.runExecByName("SearchForBattle.exe");
			AHK.runExecByName("5SecSleep.exe");
			AHK.runExecByName("ZoomOutTopRight.exe");
			AHK.runExecByName("5SecSleep.exe");
			AHK.runExecByName("BarchDeploy.exe", campSizeForCurrentAccount);
			AHK.runExecByName("3MinSleep.exe");
			AHK.runExecByName("LeaveBattle.exe");
			AHK.runExecByName("5SecSleep.exe");
			AHK.runExecByName("ZoomOutTopRight.exe");
			AHK.runExecByName("GoToBuilderBase.exe");
			AHK.runExecByName("ZoomOutTopRight.exe");
			AHK.runExecByName("BuilderBaseActionsandLeaveBuilderBase.exe");
			AHK.runExecByName("ZoomOutTopRight.exe");
			AHK.runExecByName("Retrain.exe", campSizeForCurrentAccount);
			AHK.runExecByName("3MinSleep.exe");
			AHK.runExecByName("3MinSleep.exe");
			if(ACCOUNT_SWITCHING_ENABLED && (System.currentTimeMillis() - curAcctStartingTime > ACCOUNT_TIME_BEFORE_SWITCH)){
				curAcctStartingTime = System.currentTimeMillis();
				curAcct = curAcct + 1;
				if((curAcct-1) > accounts.size() || curAcct > ACC_HIGH_RANGE){
					curAcct = ACC_MIN_RANGE;
				}
				logger.info("Changing to account " + curAcct + " of " + accounts.size() + " at time " + System.currentTimeMillis() + ".");
				AHK.runExecByName("ChangeToAccount.exe", curAcct + "");
			}
			if(iters % 100 == 0){
				logger.info(iters + " iterations completed.");
			}
			++iters;
		}
	}

	private static void trainBarch() {
			AHK.runExecByName("Retrain.exe", "100");
	}

	private static void test() {
		for(int a = 0; a < 15; ++a){
		}
	}

}