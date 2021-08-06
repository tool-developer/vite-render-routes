import { createApp } from 'vue'
import App from '../App.vue'
import router from './router';

{{#AppFileExisted}}
import appUse from './app';
{{/AppFileExisted}}

const app = createApp(App);

app.use(router);

{{#AppFileExisted}}
appUse(app)
{{/AppFileExisted}}

app.mount('#{{{MountRootId}}}')

export default app;