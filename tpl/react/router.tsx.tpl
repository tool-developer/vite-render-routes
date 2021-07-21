import React from 'react';
import {BrowserRouter,Link} from 'react-router-dom';
import renderRoutes from "./renderRoutes";
//
import routes from './route.config';
//
import {
  createBrowserHistory,
  // createHashHistory,
  // createMemoryHistory,
} from 'history-with-query';

//
export const history = createBrowserHistory({});
//
export {
	Link
}
//
export default ()=>{
	//
	return (	
		<BrowserRouter>
			{renderRoutes(routes as any)}
		</BrowserRouter>
	)
}