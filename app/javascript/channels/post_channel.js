import consumer from "./consumer"



const postChannel = consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    if (data.post_id) {
      const postDisplay = document.querySelector(`#post-${data.post_id}-comments`);
      postDisplay.insertAdjacentHTML('beforeend', data.html);
    } else {
      const postDisplay = document.querySelector('#new-posts');
      postDisplay.insertAdjacentHTML('afterbegin', data.html);
    }
  },


});
