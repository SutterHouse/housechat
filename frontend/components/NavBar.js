import React, { Component } from 'react';

var NavBar = (props) => {
  return (
    <div>
    <div className='navbar-container'>
      <img src='logo.png' className='logo' />
      <div className='navbar-element'>
          <div className='navbar-element-info'>Display Name:</div>
          <input type='text' className='navbar-element-info' onChange={props.updateUsername}/>
      </div>
    </div>
    </div>
  )
}

NavBar.displayName = 'NavBar';
export default NavBar;