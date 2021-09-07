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
    renderRoutes:'renderRoutes.tsx',
    locale:'locale.tsx'
  },
  vue:{
    routeConfig:'route.config.ts',
    main:'main.ts',
    router:'router.ts',
    locale:'locale.ts'
  }
}
const momentLocale = {
  'en-US':'',
  'fa-IR':'fa',
  'id-ID':'id',
  'ja-JP':'ja'
}
//
const handleSuffix = (suffix)=>{
  //
  return /^\./.test(suffix) ? suffix : `.${suffix}`;
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
  const {routes} = options;
  let {src,suffix,type,mountRootId,locale,strictMode} = options;
  // main.ts是否使用React.StrictMode
  const ReactStrictMode = !!strictMode;
  //
  type = type || 'react';
  mountRootId = (mountRootId || 'app').replace(/^#/,'');// remove #
  suffix = handleSuffix(suffix);
  //
  src = src || `./src`;
  src = src.replace(/\/$/,'');
  const woDir = src + '/.wo';
  const appFile = src + '/app.ts';
  // const cwd = process.cwd();
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
      const data = {
        Routes:`${JSON.stringify(result,null,2)}`.replace(/("component":\s)"([^"]+)"/g,"$1$2"),
        AppFileExisted:fs.existsSync(appFile),
        MountRootId:mountRootId,
        ReactStrictMode
      };
      //
      if(locale){
        if(typeof locale === 'boolean'){
          locale = {
            antd:true,
            default: 'zh-CN',
          }
        }
        locale.src = locale.src || './src/locales';
        locale.default = locale.default || 'zh-CN';
        locale.suffix = handleSuffix(locale.suffix || '.ts');
        const momentLocaleDefault = momentLocale[locale.default];
        locale.moment = locale.moment || (momentLocaleDefault !== undefined ? momentLocaleDefault : locale.default.toLowerCase());
        // zh-CN
        data['LocaleName'] = locale.default.split('-').join('-');
        if(locale.antd){
          // zh_CN
          data['AntdLocale'] = locale.default.split('-').join('_');
        }
        //
        const localeFile = `${locale.src}/${locale.default}`;
        if(fs.existsSync(`${localeFile}${locale.suffix}`)){
          //
          data['LocaleFile'] = path.relative(woDir,localeFile);
          data['MomentLocale'] = locale.moment;
        }
        //
        if(locale.locales){
          data['Locales'] = JSON.stringify(locale.locales,null,2);
        }
        //
        data['MomentLocaleKV'] = JSON.stringify(momentLocale,null,2);
      }
      //
      if(!data['LocaleFile'] || data['Locales']){
        delete typeFiles['locale'];
      }
      //
      Object.keys(typeFiles).forEach((name)=>{
        //
        generate({
          dir:woDir,
          type,
          name:typeFiles[name],
          data
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