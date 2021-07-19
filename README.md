# vite-render-routes
vite 路由处理，支持vue和react路由配置。

该插件，会在src目录下生产.wo目录，保存编译之后的route.config.ts文件

所以，为了保持目录结构一致，路由文件约定在src/config目录下。

## 目录结构约定：
```
src/
  config/
      route.config.ts
  pages/
      index/
        index.tsx
        index.less
      home/
        index.tsx
        index.less
      about/
        index.tsx
        index.less
      children/
        one/
          index.tsx
          index.less
index.html
vite.config.ts              
```

### 路由配置
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
### React配置：

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
### Vue配置：

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
### 配置参数
| 参数	| 说明 | 
| :-- | :-- | 
| routes	| 必填，路由配置数据 | 
| suffix	| 文件后缀，如果路由配置有该参数，不需要传递 | 
| src	| 源文件目录，默认为./src | 
| type	| 路由类型，默认react，目前仅支持vue和react | 


## 调整入口引用
index.html
```
<script type="module" src="/src/.wo/main.ts"></script>
```


## 相关说明
src/.wo目录下，除了生成route.config.ts文件外，还有main.ts和router.ts文件。

目前并未严格处理，只是生成简单文件而已。

所以，只需要使用编译之后的路由文件即可，其他文件可忽略。

此种情况，只需要调整index.html不使用src/.wo/main.ts作为入口文件即可。

## 写在后面

只是提供一种处理思路，对于Vue的路由处理，后续应该不会完善，主要只针对React进行处理。