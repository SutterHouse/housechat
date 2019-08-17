import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';

import { ActionCableProvider } from 'react-actioncable-provider';

const httpServerUrl = window.location.origin + '/messages';

const AppJsx = <ActionCableProvider url='ws://localhost:3000/cable'>
  <App httpServerUrl={httpServerUrl} />
</ActionCableProvider>;

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(AppJsx, document.getElementById('root'));
});
