package io;

public class ClashInfo {
	private int campSize;
	private int numBarracks;

	public ClashInfo(int cs, int nb) {
		campSize = cs;
		numBarracks = nb;
	}

	public int getCampSize(){
		return campSize;
	}

	public int getNumBarracks(){
		return numBarracks;
	}
}