import React from 'react';
import {Router,Link} from 'react-router-dom';
import renderRoutes,{findExceptionComponent} from "./renderRoutes";
//
import routes from './route.config';
//
import {
  createBrowserHistory,
  // createHashHistory,
  // createMemoryHistory,
} from 'history-with-query';
import { useAccess } from './hooks';

//
export const history = createBrowserHistory({});
//
export {
	Link
}
//
export default ()=>{
	const access = useAccess();
	// 全局403
	const exceptionRoutes = (routes.find((route:any)=>route.path === '/exception') || {}).routes || [];
	const exceptionComponent =  findExceptionComponent(exceptionRoutes);
	//
	return (	
		<Router history={history}>
			{renderRoutes({
				routes,
				access,
				exceptionComponent
			})}
		</Router>
	)
}