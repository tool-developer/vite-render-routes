# vite-render-routes
vite 路由处理，支持vue和react路由配置。

该插件，会在src目录下生产.wo目录，保存编译之后的route.config.ts文件

所以，为了保持目录结构一致，路由文件约定在src/config目录下。

src/config/route.config.ts
```
const routes = [{
  path: '/',
  name: 'Index',
  exact: true,
  component:'../App'
},{
  path: '/home',
  name: 'Home',
  component:'../pages/home'
},{
  path: '/about',
  name: 'About',
  component:'../pages/about'
},,{
  path: '/children',
  name: 'Children',
  routes:[{
    path: '/children/one',
    name: 'ChildrenOne',
    component:'../pages/children/one'
  }]
}]
```
React配置：

vite.config.ts
```
import { reactRenderRoutes as renderRoutes } from '@tool-developer/vite-render-routes'
import routes from './src/config/route.config'

export default defineConfig({
  plugins: [
    renderRoutes({
      routes,
      suffix:'.tsx'
    })
  ]
})

```
Vue配置：

vite.config.ts
```
import { vueRenderRoutes as renderRoutes } from '@tool-developer/vite-render-routes'

import routes from './src/config/route.config'

export default defineConfig({
  plugins: [
    renderRoutes({
      routes,
      suffix:'.vue'
    })
  ]
})

```

index.html
```
<script type="module" src="/src/.wo/main.ts"></script>
```



src/.wo目录下，除了生成route.config.ts文件外，还有main.ts和router.ts文件。

目前并未严格处理，只是生成简单文件而已。

所以，只需要使用编译之后的路由文件即可，其他文件可忽略。

此种情况，只需要调整index.html不使用src/.wo/main.ts作为入口文件即可。

