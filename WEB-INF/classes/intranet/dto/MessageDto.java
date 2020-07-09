package intranet.dto;

import java.sql.Timestamp;

public class MessageDto {
	private String mnum;
	private String mwriter;
	private String mreader;
	private String mcontent;
	private String mwriterdel;
	private String mreaderdel;
	private Timestamp mwriteday;
	private String checks;
	
	
	public String getChecks() {
		return checks;
	}
	public void setChecks(String checks) {
		this.checks = checks;
	}
	public String getMnum() {
		return mnum;
	}
	public void setMnum(String mnum) {
		this.mnum = mnum;
	}
	public String getMwriter() {
		return mwriter;
	}
	public void setMwriter(String mwriter) {
		this.mwriter = mwriter;
	}
	public String getMreader() {
		return mreader;
	}
	public void setMreader(String mreader) {
		this.mreader = mreader;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public String getMwriterdel() {
		return mwriterdel;
	}
	public void setMwriterdel(String mwriterdel) {
		this.mwriterdel = mwriterdel;
	}
	public String getMreaderdel() {
		return mreaderdel;
	}
	public void setMreaderdel(String mreaderdel) {
		this.mreaderdel = mreaderdel;
	}
	public Timestamp getMwriteday() {
		return mwriteday;
	}
	public void setMwriteday(Timestamp mwriteday) {
		this.mwriteday = mwriteday;
	}
	
	
}
