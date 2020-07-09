package intranet.dto;

import java.sql.Timestamp;

public class BoardDto {
	private String bnum;
	private int boardtype;
	private int bnotice;
	private String bsubject;
	private String bcontent;
	private int breadcount;
	private int blike;
	private String bopen;
	private Timestamp bwriteday;
	private String bcommu;
	private String num;
	
	
	 
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getBnum() {
		return bnum;
	}
	public void setBnum(String bnum) {
		this.bnum = bnum;
	}
	public int getBoardtype() {
		return boardtype;
	}
	public void setBoardtype(int boardtype) {
		this.boardtype = boardtype;
	}
	public int getBnotice() {
		return bnotice;
	}
	public void setBnotice(int bnotice) {
		this.bnotice = bnotice;
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
	public String getBopen() {
		return bopen;
	}
	public void setBopen(String bopen) {
		this.bopen = bopen;
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
