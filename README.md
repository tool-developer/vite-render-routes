# vite-render-routes
vite 路由，多语言处理，支持vue和react路由配置。

该插件，会在src目录下生产.wo目录，保存编译之后的route.config.ts文件

所以，为了保持目录结构一致，路由文件约定在src/config目录下。


## 安装
```
yarn add -D @tool-developer/vite-render-routes
```
使用的是rollup插件，并非vite插件，命名未按照相关规范。


## 目录结构约定：
```
src/
  app.ts
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
  locales/
    en-US/
      ...
    zh-CN/
      ...
    zh-TW/
      ...
    en-US.ts
    zh-CN.ts
    zh-TW.ts        
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

### locale配置
locales/zh-CN.ts
```
import component from './zh-CN/component';
import globalHeader from './zh-CN/globalHeader';
import menu from './zh-CN/menu';
// 其他引入

export default {
  'navBar.lang': '语言',
  'layout.user.link.help': '帮助',
  'layout.user.link.privacy': '隐私',
  'layout.user.link.terms': '条款',
  'app.preview.down.block': '下载此页面到本地项目',
  'app.welcome.link.fetch-blocks': '获取全部区块',
  'app.welcome.link.block-list': '基于 block 开发，快速构建标准页面',
  ...globalHeader,
  ...menu,
  ...component
};
```
locales/zh-CN/menu.ts
```
import menuBase from './menu.base'

export default {
  ...menuBase,
  'menu.welcome': '欢迎',
  'menu.home': '首页',
  // ...
};
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
      suffix:'.tsx',
      locale:true,
      strictMode:false,// React.StrictMode模式下antd会出现findDOMNode错误
      /*locale: {
        // default zh-CN
        default: 'zh-CN',
        antd: true,
        // baseNavigator: true,
      },*/
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
| mountRootId	| index.html根节点id，默认为root | 
| strictMode	| 是否使用React strictMode模式，默认false | 


## 调整入口引用
index.html
```
<script type="module" src="/src/.wo/main.ts"></script>
```
## app.ts处理
### React app.ts
```
const app = {};

//

export default app;
```
### Vue app.ts
可以通过app.ts注入更多app.use处理
```
import store from "./store";

import ElementPlus from "element-plus"
import "element-plus/lib/theme-chalk/index.css"

import "./assets/css/setting.css"
import "./assets/css/global.css"

import { i18n } from './i18n';

export default (app)=>{
	//
	app.use(store);
	app.use(ElementPlus, { size: "mini", i18n: i18n.global.t });
	app.use(i18n);
}
```

## 安装依赖
react需安装依赖：
```
yarn add react-dom react-router-dom react-router-config
```
```
yarn add react-intl
```
vue需安装依赖：
```
yarn add vue-router 
```
```
yarn add vue-intl
```

## 相关说明
src/.wo目录下，除了生成route.config.ts文件外，还有main.ts和router.ts文件。

目前并未严格处理，只是生成简单文件而已。

所以，只需要使用编译之后的路由文件即可，其他文件可忽略。

此种情况，只需要调整index.html不使用src/.wo/main.ts作为入口文件即可。

## 写在后面

只是提供一种处理思路，对于Vue的路由处理，后续应该不会完善，主要只针对React进行处理。