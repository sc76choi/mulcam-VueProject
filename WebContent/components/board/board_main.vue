 <template>
<div class="container" style="margin-top:100px">
	<div class="card shadow">
		<div class="card-body">
			<h4 class="card-title">{{server_data.board_info_name}}</h4>
			<table class="table table-hover" id='board_list'>
				<thead>
					<tr>
						<th class="text-center d-none d-md-table-cell">글번호</th>
						<th class="w-50">제목</th>
						<th class="text-center d-none d-md-table-cell">작성자</th>
						<th class="text-center d-none d-md-table-cell">작성날짜</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for='obj in server_data.board_list' @click='go_board_read'>
						<td class="text-center d-none d-md-table-cell">{{obj.content_idx}}</td>
						<td>{{obj.content_subject}}</td>
						<td class="text-center d-none d-md-table-cell">{{obj.content_writer_name}}</td>
						<td class="text-center d-none d-md-table-cell">{{obj.content_date}}</td>
						
					</tr>
				</tbody>
			</table>
			
			<div class="d-none d-md-block">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<router-link :to="'/board_main/' + $route.params.board_info_idx + '/' + server_data.pre" class="page-link">이전</router-link>
					</li>
					<li class="page-item" v-for="pagenum in server_data.page_array">
						<router-link :to="'/board_main/' + $route.params.board_info_idx + '/' + pagenum" class="page-link">{{pagenum}}</router-link>
					</li>
					<li class="page-item">
						<router-link :to="'/board_main/' + $route.params.board_info_idx + '/' + server_data.next" class="page-link">다음</router-link>
					</li>
				</ul>
			</div>
			
			<!--
			<div class="d-block d-md-none">
				<ul class="pagination justify-content-center">
					<li class="page-item">
						<router-link to="/board_main" class="page-link">이전</router-link>
					</li>
					<li class="page-item">
						<router-link to="/board_main" class="page-link">다음</router-link>
					</li>
				</ul>
			</div>
			-->
			
			<div class="text-right">
				<router-link :to="'/board_write/' + $route.params.board_info_idx" class="btn btn-primary" v-if='$store.state.user_login_check == true'>글쓰기</router-link>
			</div>
			
		</div>
	</div>
</div>
 </template>

<script>
	// template 태그에서 이용가능 하게 함
	module.exports = {
		data: function() {
			return {
				temp_list: [1,2,3,4,5,6,7,8,9,10],
				server_data : {}
				
			}
		},
		methods: {
			go_board_read: function() {
				<!-- alert('go_board_read') -->
				this.$router.push("/board_read")
			},
			// 게시판 이름가져오기
			get_board_data : function() {
				//alert("" + this.$route.params.board_info_idx)
				
				// 문자열 데이터만 담을 수 있음
				let params = new URLSearchParams()
				params.append("board_info_idx", this.$route.params.board_info_idx)
				params.append("page", this.$route.params.page)
				
				axios.post('server/board/get_board_list.jsp', params).then((response) => {
					this.server_data = response.data
				})
			}
		},
		// to, from은 주소와 관련된 정보가 있음
		watch: {
			'$route' (to, from) {
				//alert(to + " " + from)
				this.get_board_data()
			}
		},
		// 이미 만들어진 component 를 사용해서 router가 변경되어도 감시 못함
		created() {
			this.get_board_data()
		},
		
	}
	

</script>

 <style>
	#board_list > tbody > tr {
		cursor: pointer;
	}
</style>