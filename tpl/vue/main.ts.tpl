import { createApp } from 'vue'
import App from '../App.vue'
import router from './router';

{{#appFileExisted}}
import appUse from './app';
{{/appFileExisted}}

const app = createApp(App);

app.use(router);

{{#appFileExisted}}
appUse(app)
{{/appFileExisted}}

app.mount('#{{{mountRootId}}}')

export default app;