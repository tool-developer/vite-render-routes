import { createRouter,createWebHashHistory } from "vue-router"
import routes from './route.config'

const router = createRouter({
    history: createWebHashHistory(),
    routes
})

// router.beforeEach((to, from, next) => {
// 	next()
// })

export default router;