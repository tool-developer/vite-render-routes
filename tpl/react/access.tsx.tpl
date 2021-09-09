import React,{useContext} from 'react';
import {AccessContext} from './context';

export const useAccess = ()=>{
  const {access} = useContext(AccessContext);

  return access;
}

export interface AccessProps {
  accessible: boolean;
  fallback?: React.ReactNode;
}

export const Access:React.FC<AccessProps>=props=>{
  const { accessible, fallback, children } = props;
  //
  return <>{accessible ? children : fallback}</>;
}