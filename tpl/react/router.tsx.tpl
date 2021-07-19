import React from 'react';
import {BrowserRouter} from 'react-router-dom';
import { renderRoutes  } from "react-router-config";
//
import routes from './route.config';
//
export default ()=>{

	return (	
		<BrowserRouter>
			{renderRoutes(routes as any)}
		</BrowserRouter>
	)
}