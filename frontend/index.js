import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App';
import io from 'socket.io-client';

var httpServer = window.location.origin + '/messages';
var webSocketServer = io(window.location.origin);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<App httpServer={httpServer} webSocketServer={webSocketServer}/>, document.getElementById('root'));
});
