import React,{useState} from 'react';
import {
  createIntl,
  IntlShape,
  RawIntlProvider
} from 'react-intl'
//
{{#AntdLocale}}
import antdLocale from 'antd/es/locale/{{{AntdLocale}}}';
{{/AntdLocale}}
//
{{#LocaleFile}}
import locales from '{{{LocaleFile}}}';
{{/LocaleFile}}

//
interface IntlShapeExt extends IntlShape {
  [key:string]:any;
}
//
const momentLocaleKV:{[key:string]:string} ={{{MomentLocaleKV}}};

//
let localeInfo = {
  {{#LocaleFile}}
  messages:locales,
  {{/LocaleFile}}
  {{#Locales}}
  messages:{{{Locales}}},
  {{/Locales}}
  locale:'{{{LocaleName}}}',
  {{#AntdLocale}}
  antd:antdLocale,
  {{/AntdLocale}}
  momentLocale:'{{{MomentLocale}}}'
}

//
function getMomentLocale(moment:string){
  const momentLocale = momentLocaleKV[moment];
  //
  return (momentLocale !== undefined ? momentLocale : moment.toLowerCase());    
}

//
export * from 'react-intl'

//
export const getIntl = ()=>{
  //
  return createIntl(localeInfo);
}

export const setIntl = (locale:IntlShapeExt)=>{
  //
  const momentLocale = locale.momentLocale || getMomentLocale(locale.moment);
  //
  const info = {
    ...locale,
    message:locale.message || locale.locales,
    momentLocale
  }
  //
  localeInfo = info;
  //
  return createIntl(info);
}


export default (props:any)=>{
  const {children} = props;
  const [intl] = useState(()=>getIntl())

  return <RawIntlProvider value={intl}>{children}</RawIntlProvider>
}