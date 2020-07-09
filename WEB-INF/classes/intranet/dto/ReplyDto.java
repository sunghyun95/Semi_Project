package intranet.dto;

import java.sql.Timestamp;

public class ReplyDto {
	private String rnum;
	private String bnum;
	private String num;
	private String rcontent;
	private Timestamp rwriteday;
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
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
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public Timestamp getRwriteday() {
		return rwriteday;
	}
	public void setRwriteday(Timestamp rwriteday) {
		this.rwriteday = rwriteday;
	}
	
	
}