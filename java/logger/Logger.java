package logger;

public class Logger {
	//todo make this log to a file.
	private Class clazz;
	public Logger(Class c) {
		clazz=c;
	}

	public void info(String msg) {
		System.out.println("INFO: " + clazz.getName() + ": " + msg);
	}

	public void warn(String msg) {
		System.out.println("WARN: " + clazz.getName() + ": " + msg);
	}

	public void error(String msg) {
		System.out.println("ERROR: " + clazz.getName() + ": " + msg);
	}
}