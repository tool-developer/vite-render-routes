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

export default function renderRoutes(routes:RouteConfigExt,extraProps={},switchProps={}){
  //
  return routes ? (
    <Switch {...switchProps}>
      {
        routes.map((route:RouteConfigExt,i:number) => {
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
                const childRoutes = renderRoutes(route.routes, extraProps, {
                  location: props.location,
                });
                //
                if(route.render){
                  //
                  return route.render({...props,...extraProps,route:route});
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