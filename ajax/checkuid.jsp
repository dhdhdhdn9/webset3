<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
   String DRV = "org.mariadb.jdbc.Driver";
   String URL = "jdbc:mariadb://bigdata.chasrr6acj7c.ap-northeast-2.rds.amazonaws.com:3306/playground";
   String USR = "playground";
   String PWD = "bigdata2020";

   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;

   String sql = "SELECT count(userid) cnt from member where userid = ?";
   StringBuffer sb = new StringBuffer();

   try {
        Class.forName(DRV);
        conn = DriverManager.getConnection(URL, USR, PWD);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, request.getParameter("uid"));

        rs = pstmt.executeQuery();
        if (rs.next()) {
            int cnt = rs.getInt(1);
            if (cnt > 0) sb.append("yes");
            else sb.append("no");
        }
   } catch (Exception ex) {
        ex.printStackTrace();

   } finally {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(conn != null) conn.close();
   }

   out.write(sb.toString());
<!-- 꼭 출력시켜서 확인!! document.write()하고 printIn 같은 역할.
rs.next()는 다음 행이 존재한다면 rs.next()는 true를 리턴, 즉 rs.next()에 의해 다음 행을 실행한다는 것임. 다음 행에 해당하는 값이 없다면 'else'로 정의한 행을 실행-->
%>
