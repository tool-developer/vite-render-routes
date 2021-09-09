import {useContext} from 'react';
import {AccessContext} from './context';

export const useAccess = ()=>{
  const {access} = useContext(AccessContext);
  //
  return access;
}

export const useApp = (defaults:any)=>{
  const app:any = useContext(AccessContext);

  //
  return app || {};
}