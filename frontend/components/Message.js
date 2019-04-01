import React from 'react';

const Message = (props) => (
  <div className='message-container'>
    { JSON.stringify(props.message) }: { props.message.text }
  </div>
)

Message.displayName = 'Message';
export default Message;