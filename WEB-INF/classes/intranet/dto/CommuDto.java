package intranet.dto;

import java.sql.Timestamp;

public class CommuDto {
	private String bnum;
	private String boardtype;
	private String bsubject;
	private String bcontent;
	private String num;
	private int breadcount;
	private int blike;
	private Timestamp bwriteday;
	private String bcommu;
	
	public String getBnum() {
		return bnum;
	}
	public void setBnum(String bnum) {
		this.bnum = bnum;
	}
	public String getBoardtype() {
		return boardtype;
	}
	public void setBoardtype(String boardtype) {
		this.boardtype = boardtype;
	}
	public String getBsubject() {
		return bsubject;
	}
	public void setBsubject(String bsubject) {
		this.bsubject = bsubject;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public int getBreadcount() {
		return breadcount;
	}
	public void setBreadcount(int breadcount) {
		this.breadcount = breadcount;
	}
	public int getBlike() {
		return blike;
	}
	public void setBlike(int blike) {
		this.blike = blike;
	}
	public Timestamp getBwriteday() {
		return bwriteday;
	}
	public void setBwriteday(Timestamp bwriteday) {
		this.bwriteday = bwriteday;
	}
	public String getBcommu() {
		return bcommu;
	}
	public void setBcommu(String bcommu) {
		this.bcommu = bcommu;
	}
	
}
