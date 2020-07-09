package intranet.dto;

import java.sql.Timestamp;

public class JehyuDto {
   private String num;
   private String jhname;
   private String jhaddr;
   private String jhcontent;
   private String wido;
   private String gyungdo;
   private Timestamp writeday;
   
   
   public String getNum() {
      return num;
   }
   public void setNum(String num) {
      this.num = num;
   }
   public String getJhname() {
      return jhname;
   }
   public void setJhname(String jhname) {
      this.jhname = jhname;
   }
   public String getJhaddr() {
      return jhaddr;
   }
   public void setJhaddr(String jhaddr) {
      this.jhaddr = jhaddr;
   }
   public String getJhcontent() {
      return jhcontent;
   }
   public void setJhcontent(String jhcontent) {
      this.jhcontent = jhcontent;
   }
   public String getWido() {
      return wido;
   }
   public void setWido(String wido) {
      this.wido = wido;
   }
   public String getGyungdo() {
      return gyungdo;
   }
   public void setGyungdo(String gyungdo) {
      this.gyungdo = gyungdo;
   }
   public Timestamp getWriteday() {
      return writeday;
   }
   public void setWriteday(Timestamp writeday) {
      this.writeday = writeday;
   }
}