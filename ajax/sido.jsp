<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
   String DRV = "org 드라이버";
   String URL = "db주소";
   String USR = "데이터";
   String PWD = "비밀번호";

   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;

   String sql = "SELECT distinct SIDO from zipcode";
   StringBuffer sb = new StringBuffer();

   try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(sql);

        rs = pstmt.executeQuery();
        while (rs.next()) {
            String sido = rs.getString(1);
            sb.append(sido).append(',');
        }
   } catch (Exception ex) {
        ex.printStackTrace();

   } finally {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
   }

   out.write(sb.toString());
%>

