import React from 'react'
import ReactDOM from 'react-dom'

import Router from './router';
import LocaleWraper from './locale';


ReactDOM.render(
  {{#ReactStrictMode}}
  <React.StrictMode>
  {{/ReactStrictMode}}
    <LocaleWraper>
      <Router />
    </LocaleWraper>
  {{#ReactStrictMode}}  
  </React.StrictMode>
  {{/ReactStrictMode}}
  ,
  document.getElementById('{{{MountRootId}}}')
)