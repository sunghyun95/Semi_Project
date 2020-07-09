package intranet.dto;

import java.sql.Timestamp;

public class DiaryDto {
	private String dnum;
	private String num;
	private String startdate;
	private String enddate;
	private String dsubject;
	private String dcontent;
	private Timestamp dwriteday;
	private String diarytype;
	
	
	public String getDiarytype() {
		return diarytype;
	}
	public void setDiarytype(String diarytype) {
		this.diarytype = diarytype;
	}
	public String getDnum() {
		return dnum;
	}
	public void setDnum(String dnum) {
		this.dnum = dnum;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getDsubject() {
		return dsubject;
	}
	public void setDsubject(String dsubject) {
		this.dsubject = dsubject;
	}
	public String getDcontent() {
		return dcontent;
	}
	public void setDcontent(String dcontent) {
		this.dcontent = dcontent;
	}
	public Timestamp getDwriteday() {
		return dwriteday;
	}
	public void setDwriteday(Timestamp dwriteday) {
		this.dwriteday = dwriteday;
	}
	
	
}
