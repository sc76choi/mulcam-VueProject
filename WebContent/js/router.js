let store = new Vuex.Store({
	state: {
		user_login_check: false,
		user_id: '',
		user_name: '',
		user_idx: 0
	}
})

let router = new VueRouter({
	routes : [
		{
			path : '/',
			component : httpVueLoader('components/main/main.vue')
		},
		{
			path: '/board_main/:board_info_idx/:page',
			component : httpVueLoader('components/board/board_main.vue')
		},
		{
			path: '/login',
			component : httpVueLoader('components/user/login.vue')
		},
		{
			path: '/join',
			component : httpVueLoader('components/user/join.vue')
		},
		{
			path: '/modify_user',
			component : httpVueLoader('components/user/modify_user.vue')
		},
		{
			path: '/board_read/:board_info_idx/:page/:content_idx',
			component : httpVueLoader('components/board/board_read.vue')
		},
		{
			path: '/board_modify',
			component : httpVueLoader('components/board/board_modify.vue')
		},
		{
			path: '/board_delete',
			beforeEnter: (to, from, next) => {
				alert('삭제되었습니다.')
				next('/board_main')
			}
		},
		{
			path: '/board_write/:board_info_idx',
			component : httpVueLoader('components/board/board_write.vue')
		},
		{
			path: '/logout',
			beforeEnter: (to, from, next) => {
				alert('로그아웃되었습니다.')
				
				store.state.user_login_check = false
				store.state.user_login_id = ''
				store.state.user_login_name = ''
				store.state.user_login_idx = 0
				
				sessionStorage.clear()
				
				next('/')
			}
		}
	],
	scrollBehavior (to, from, savedPosition) {
		return {
			x: 0,
			y: 0
		}
	}
})