<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>

<%
	// 데이터 베이스 접속 정보
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String id = "scott";
	String pw = "tiger";
	
	// 접속
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url, id, pw);
	
	// 파라미터 한글처리
	request.setCharacterEncoding("utf-8");
	
	// 브라우저가 전달하는 파라미터를 추출한다.
	String user_id = request.getParameter("user_id");
	
	String sql = "select * from user_table where user_id = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_id);
	
	// 쿼리 실행
	ResultSet rs = pstmt.executeQuery();
	boolean check = rs.next();
	
	db.close();
%>

{
	"check_result" : <%=check%>
}
