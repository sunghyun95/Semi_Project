package intranet.dto;

import java.sql.Timestamp;

public class ScrapDto {
	private String snum;
	private String bnum;
	private String num;
	private Timestamp swriteday;
	public String getSnum() {
		return snum;
	}
	public void setSnum(String snum) {
		this.snum = snum;
	}
	public String getBnum() {
		return bnum;
	}
	public void setBnum(String bnum) {
		this.bnum = bnum;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public Timestamp getSwriteday() {
		return swriteday;
	}
	public void setSwriteday(Timestamp swriteday) {
		this.swriteday = swriteday;
	}
	
	
}
