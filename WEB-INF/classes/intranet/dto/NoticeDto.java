package intranet.dto;

import java.sql.Timestamp;

public class NoticeDto {
   
   private String bnum;
   private String bnotice;
   private String bsubject;
   private String bcontent;
   private String num;
   private String breadcount;
   private String blike;
   private String bopen;
   private Timestamp bwriteday;
   private String bcommu;
   private String boardtype;
   
   

   public String getBnum() {
      return bnum;
   }
   public void setBnum(String bnum) {
      this.bnum = bnum;
   }
   public String getBnotice() {
      return bnotice;
   }
   public void setBnotice(String bnotice) {
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
   public String getNum() {
      return num;
   }
   public void setNum(String num) {
      this.num = num;
   }
   public String getBreadcount() {
      return breadcount;
   }
   public void setBreadcount(String breadcount) {
      this.breadcount = breadcount;
   }
   public String getBlike() {
      return blike;
   }
   public void setBlike(String blike) {
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
   public String getBoardtype() {
      return boardtype;
   }
   public void setBoardtype(String boardtype) {
      this.boardtype = boardtype;
   }
   
   
}