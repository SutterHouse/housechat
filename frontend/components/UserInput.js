import React from 'react';

class UserInput extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputValue: ''
    }
  }

  submitHandler(e) {
    e.preventDefault();
    this.props.sendNewMessage(this.state.inputValue);
    this.setState({ inputValue: '' });
  }

  inputChangeHandler(e) {
    this.setState({ inputValue: e.target.value });
  }

  render() {
    return (
      <div className='user-input-container'>
        <form onSubmit={this.submitHandler.bind(this)}>
          <input 
            className='input-field' 
            type='text' value={this.state.inputValue} 
            onChange={this.inputChangeHandler.bind(this)} 
            placeholder='Your message here...' 
          />
          <input className='submit-btn' type='submit' value='Send' />
        </form>
      </div>
    );
  }
}

UserInput.displayName = 'UserInput';
export default UserInput;