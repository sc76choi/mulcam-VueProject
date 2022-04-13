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
	
	String str1 = request.getParameter("board_info_idx");
	int board_info_idx = Integer.parseInt(str1);
	
	// 게시판 정보를 가져오는 부분
	String sql = "select board_info_idx, board_info_name from board_info_table where board_info_idx = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setInt(1, board_info_idx);
	
	// 쿼리 실행
	ResultSet rs = pstmt.executeQuery();
	
	// 모든데이터를 담아 놓을 JSON Object
	JSONObject root = new JSONObject();
	
	int i = 0;
	rs.next();
	//JSONObject obj = new JSONObject();
	
	String board_info_name = rs.getString("board_info_name");
	root.put("board_info_name", board_info_name);
	
	db.close();
%>

<%= root.toJSONString() %>