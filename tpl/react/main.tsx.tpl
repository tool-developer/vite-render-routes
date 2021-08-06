import React from 'react'
import ReactDOM from 'react-dom'

import Router from './router';
import LocaleWraper from './locale';


ReactDOM.render(
  <React.StrictMode>
    <LocaleWraper>
      <Router />
    </LocaleWraper>
  </React.StrictMode>,
  document.getElementById('{{{MountRootId}}}')
)