import React from 'react';
import {Switch,Route,Redirect} from 'react-router-dom';
import {RouteProps} from 'react-router';
import {RouteConfigExt} from './route.config'
//
const RenderRoute:any = ({ path, exact, strict, render, location, sensitive, ...rest }:RouteProps) => (
  <Route
    path={path}
    exact={exact}
    strict={strict}
    location={location}
    sensitive={sensitive}
    render={props => render && render({ ...props, ...rest })}
  />
);
//
const Exception403 = ()=>{
  //
  return <div>Sorry, you don't have access to this page.</div>
}

export interface routeOptions {
  routes:RouteConfigExt;
  access:any;
  extraProps?:any;
  exceptionComponent?:any;
}

export function findExceptionComponent(routes:any=[]){
	const exceptions403 =  routes.find((route:any)=>route.path === '/exception/403' || route.path === '/403') || {};
  //
  return exceptions403.component;
}

export default function renderRoutes(options:routeOptions){
  const {routes,access={},extraProps={},exceptionComponent} = options;
  const CurrentExceptionComponent = findExceptionComponent(routes) || exceptionComponent || Exception403;
  //
  return routes ? (
    <Switch>
      {
        routes.map((route:RouteConfigExt,i:number) => {
          //
          const accessProp = access[route.access];
          if(accessProp){
            let currentRouteAccessible = accessProp;
            if(typeof accessProp === 'function'){
              currentRouteAccessible = accessProp(route);
            }
            if(!currentRouteAccessible){
              //
              return <CurrentExceptionComponent key={route.key || i}/>;
            }
          }

          if(route.redirect){
            //
            return (
              <Redirect
                key={route.key || i}
                from={route.path}
                to={route.redirect}
                exact={route.exact}
                strict={route.strict}
              />
            );
          }
          //
          return (
            <RenderRoute
              key={route.key || i}
              path={route.path}
              exact={route.exact}
              strict={route.strict}
              sensitive={route.sensitive}
              render={(props:any) => {
                //
                const childRoutes = renderRoutes({
                  routes:route.routes, 
                  access, 
                  exceptionComponent,
                  extraProps:{
                    location: props.location,
                  }
                });
                //
                if(route.render){
                  //
                  return route.render({...props,...extraProps,route});
                }
                //
                if(route.component){
                  //
                  let { component: Component }:any = route;
                  //
                  return (
                    <Component {...props} {...extraProps} route={route}>
                      {childRoutes}
                    </Component>
                  )
                }
                //
                return childRoutes;
              }}
            />
          )
        })
      }
    </Switch>
  ) : null
}