import React, { Component } from 'react';
import axios from 'axios';
import { ActionCableConsumer } from 'react-actioncable-provider';
import MessageList from './MessageList.js';
import UserInput from './UserInput.js';
import NavBar from './NavBar.js';



class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      messages: [],
      username: 'anon'
    };
  }

  componentDidMount() {
    this.fetchPrevMessages();
  }

  fetchPrevMessages() {
    const { httpServerUrl } = this.props;
    axios.get(httpServerUrl).then(result => {
      console.log('fetch:', result.data);
      this.setState({ messages: result.data }, this.scrollToBottom);
    })
  }

  handleReceivedMessage(response) {
    console.log("received", response);
    this.setState({messages: this.state.messages.concat(response)}, this.scrollToBottom);
  }

  scrollToBottom() {
    var msgs = document.getElementsByClassName('message-list-container')[0];
    msgs.scrollTop = msgs.scrollHeight - msgs.clientHeight;
  }

  sendNewMessage(messageText) {
    var url = this.props.httpServerUrl;

    var message = {
      handle: this.state.username,
      text: messageText
    };

    console.log('message sending:', messageText);
    axios.post(url, message);
  }

  updateUsername (e) {
    var username = e.target.value;
    if (username === '') {
      username = 'anon';
    }
    this.setState({ username });
  }

  render() {
    if (!this.acc) {
      this.acc = <ActionCableConsumer
        channel={{ channel: 'MessagesStreamChannel' }}
        onReceived={this.handleReceivedMessage.bind(this)}
      />;
    }
  return (
    <div className='app-container'>
      { this.acc }
      <NavBar updateUsername={this.updateUsername.bind(this)}/>
      <MessageList messages = {this.state.messages}/>
      <UserInput sendNewMessage={this.sendNewMessage.bind(this)}/>
      <div className='footer'>
        <img src='footer.png' className='footer-logo' />
      </div>
    </div>
  );
  }
}

App.displayName = 'App';
export default App;