$(function(){
	var app = new Vue({
		el: '#app',
		components : {
			'top-menu':  httpVueLoader('components/common/top_menu.vue'),
			'bottom-info':  httpVueLoader('components/common/bottom_info.vue')
		},
		router: router,
		store: store,
		beforeCreate: function() {
			if(sessionStorage.user_login_check != undefined) {
				this.$store.state.user_login_check = sessionStorage.user_login_check
				this.$store.state.user_login_id = sessionStorage.user_login_id
				this.$store.state.user_login_pw = sessionStorage.user_login_pw
				this.$store.state.user_login_idx = sessionStorage.user_login_idx
			}
		}
	})
})