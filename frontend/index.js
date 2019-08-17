import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';

import { ActionCableProvider } from 'react-actioncable-provider';

const httpServerUrl = window.location.origin + '/messages';
const wsUrl = `ws://${window.location.hostname}${window.location.port ? `:${window.location.port}` : ""}/cable`;
const AppJsx = <ActionCableProvider url={wsUrl}>
  <App httpServerUrl={httpServerUrl} />
</ActionCableProvider>;

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(AppJsx, document.getElementById('root'));
});
