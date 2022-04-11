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
	String user_pw = request.getParameter("user_pw");
	System.out.println("user_id : " + request.getParameter("user_id"));
	System.out.println("user_pw : " + request.getParameter("user_pw"));
	
	String sql = "select user_idx, user_name, user_id, user_pw from user_table where user_id = ? and user_pw = ?";
	System.out.println("sql : " + sql);
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_id);
	pstmt.setString(2, user_pw);
	
	// 쿼리 실행
	ResultSet rs = pstmt.executeQuery();
	boolean check = rs.next();
	System.out.println("check : " + check);
	JSONObject root = new JSONObject();
	
	if(check == false) {
		root.put("result", false);
	} else {
		root.put("result", true);
		root.put("user_idx", rs.getInt("user_idx"));
		root.put("user_id", rs.getString("user_id"));
		root.put("user_pw", rs.getString("user_pw"));
		root.put("user_name", rs.getString("user_name"));
		
		session.setAttribute("login_check", true);
	}
	
	db.close();
%>
<%=root.toJSONString()%>