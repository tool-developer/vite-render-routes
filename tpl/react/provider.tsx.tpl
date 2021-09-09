import React,{useState,useEffect,useCallback} from 'react';
//
import { AccessContext } from './context';

import {getInitialState,fetchUserInfo,logout,access as accessFactory} from '../app';

//
const defaultPatchMenus = (menuData:any)=>{
  //
  return menuData;
}
//
export const AppProvider:React.FC<any> = props => {
  const {children} = props;
  const [initialState,setInitialState] = useState<any>({
    patchMenus:defaultPatchMenus,
  });
  const [access,setAccess] = useState({});
  const [currentUser,setCurrentUser] = useState({});

  const refresh = useCallback(async ()=>{
    //
    const stateInfo = await getInitialState();
    const userInfo = await fetchUserInfo();
    const accessInfo = await accessFactory(userInfo);
    //
    stateInfo.patchMenus = stateInfo.patchMenus || defaultPatchMenus;
    //
    setInitialState(stateInfo);
    setCurrentUser(userInfo);
    setAccess(accessInfo);
  },[])
  //
  useEffect(()=>{
    //
    refresh();
  },[])

  //
  return React.createElement(
    AccessContext.Provider,
    {value:{
      access,
      currentUser,
      initialState,
      logout,
      refresh
    }},
    React.cloneElement(children,{
      ...children.props
    })
  )
}