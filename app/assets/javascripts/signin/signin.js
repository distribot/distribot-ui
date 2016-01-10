"use strict";

$(document).ready(function(){
  $('.signin-form').form({
    fields: {
      email: {
        identifier: 'email',
        rules: [
          {
            type: 'empty',
            prompt: 'Please enter your email address'
          },
          {
            type: 'email',
            prompt: 'Please enter a valid email address'
          }
        ]
      },
      password: {
        identifier: 'password',
        rules: [
          {
            type: 'empty',
            prompt: 'Please enter your password'
          }
        ]
      }
    }
  });
});
