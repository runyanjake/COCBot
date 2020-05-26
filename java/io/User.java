package io;

public class User {
	private String firstName;
	private String lastName;
	private String email;
	private String emailPW;
	private String birthday;
	public User(String f, String l, String e, String epw, String b) {
		firstName = f;
		lastName = l;
		email = e;
		emailPW = epw;
		birthday = b;
	}

	public String getFirstName(){
		return firstName;
	}

	public String getLastName(){
		return lastName;
	}

	public String getEmail(){
		return email;
	}

	public String getEmailPW(){
		return emailPW;
	}

	public String getBirthday(){
		return birthday;
	}
}