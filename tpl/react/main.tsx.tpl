import React from 'react'
import ReactDOM from 'react-dom'

import Router from './router';
import LocaleWraper from './locale';

import {AppProvider} from './provider';


ReactDOM.render(
  {{#ReactStrictMode}}
  <React.StrictMode>
  {{/ReactStrictMode}}
    <LocaleWraper>
      <AppProvider>
        <Router />
      </AppProvider>
    </LocaleWraper>
  {{#ReactStrictMode}}  
  </React.StrictMode>
  {{/ReactStrictMode}}
  ,
  document.getElementById('{{{MountRootId}}}')
)