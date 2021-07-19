export default ({routes,suffix,type})=>{
  if(!import.meta){
    //
    throw new Error("Cant't support import.meta.")
  }
  //
  if(!routes){
    //
    return console.log('There is no routes data.');
  }
  //
  if(!Array.isArray(routes)){
    //
    return console.log('Routes data must be an array.');
  }
  //
  const handle = ({...route})=>{
    const {routes,exact,component} = route;
    // 默认exact设置为true
    route.exact = exact !== undefined ? exact : true;
    //
    if(typeof component === 'string'){
      let name = suffix ? `${component}${suffix}` : component;
      //
      if(type === 'react'){
        //
        route.component = `import.meta.globEager('${name}')['${name}'].default`;
      }else{
        //
        route.component = `() => import('${name}')`;
      }
    }
    //
    if(routes){
      //
      route.routes = routes.map(handle);
    }
    //  
    return route;
  }
  //
  routes = routes.map(handle);
  //
  return routes;
}