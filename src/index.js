import fs from 'fs'
import path from 'path'
import Mustache from 'mustache'
//
import handle from './handle'
//
const tplFileName = {
  react:{
    routeConfig:'route.config.ts',
    main:'main.tsx',
    router:'router.tsx',
    renderRoutes:'renderRoutes.tsx'
  },
  vue:{
    routeConfig:'route.config.ts',
    main:'main.ts',
    router:'router.ts'
  }
}
//
const generate = ({dir,type,name,data = {}}) => {
  const routeConfigFile = `${dir}/${name}`;
  const routeConfigTplPath = path.join(__dirname,`../tpl/${type}/${name}.tpl`);
  //
  if(fs.existsSync(routeConfigTplPath)){
    const routerTpl = fs.readFileSync(routeConfigTplPath, 'utf-8');
    const content = Mustache.render(routerTpl, data);
    //
    fs.writeFileSync(routeConfigFile,content);
  }
}

//
const renderRoutes = (options) => {
  //
  const {routes,suffix} = options;
  let {src,type,mountRootId} = options;
  //
  type = type || 'react';
  mountRootId = (mountRootId || 'app').replace(/^#/,'');// remove #
  //
  src = src || `./src`;
  src = src.replace(/\/$/,'');
  const woDir = src + '/.wo';
  const appFile = src + '/app.ts';
  //
  if(!fs.existsSync(woDir)){
    fs.mkdirSync(woDir);
  }
  //
  return {
    name:'render-routes',
    buildStart(){
      // console.log('--build start options--',options)
      const typeFiles = tplFileName[type] || {};
      const result = handle({routes,suffix,type});
      //
      typeFiles['data'] = {
        routes:`${JSON.stringify(result,null,2)}`.replace(/("component":\s)"([^"]+)"/g,"$1$2"),
        appFileExisted:fs.existsSync(appFile),
        mountRootId
      }
      //
      Object.keys(typeFiles).forEach((name)=>{
        //
        generate({
          dir:woDir,
          type,
          name:typeFiles[name],
          data:typeFiles['data']
        });
      })
    }
  }
}
//
export const reactRenderRoutes = (options)=>{
  //
  options.type = 'react';
  //
  return renderRoutes(options);
}
//
export const vueRenderRoutes = (options)=>{
  //
  options.type = 'vue';
  //
  return renderRoutes(options);
}

// rollup-plugin-render-routes
export default renderRoutes