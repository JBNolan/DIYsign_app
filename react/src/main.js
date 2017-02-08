import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import VoteButton from './components/VoteButton';

$(function() {
  let buttons = document.getElementsByClassName('vote');
  for(let button of buttons){
    ReactDOM.render(
      <VoteButton
        comment = {parseInt(button.dataset.id)}
      />,
      button
    );
  }
});
