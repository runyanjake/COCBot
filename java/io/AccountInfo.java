package io;

import io.User;
import io.ClashInfo;

public class AccountInfo {
	private String type;
	private User user;
	private ClashInfo clashInfo;

	public AccountInfo(String t, User u, ClashInfo c) {
		type = t;
		user = u;
		clashInfo = c;
	}

	public String getType(){
		return type;
	}

	public User getUser(){
		return user;
	}

	public ClashInfo getClashInfo() {
		return clashInfo;
	}
}