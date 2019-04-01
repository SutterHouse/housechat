import React from 'react';

const Message = (props) => (
  <div className='message-container'>
    { props.message.user_handle }: { props.message.text }
  </div>
)

Message.displayName = 'Message';
export default Message;