import {RouteConfig,RouteConfigComponentProps} from 'react-router-config'
//
type globEagerType = (pattern: string) => Record<
    string,
    {
      [key: string]: any
    }
  >;

// 改写component
interface RouteConfigExt extends Omit<RouteConfig,"component">{
  component?: React.ComponentType<RouteConfigComponentProps<any>> | React.ComponentType | globEagerType | undefined;  
};
//
const routes:RouteConfigExt = {{{routes}}}

//
export default routes;