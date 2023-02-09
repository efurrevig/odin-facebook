import consumer from "./consumer"

const postChannel = consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const postDisplay = document.querySelector('#post-display')
    postDisplay.insertAdjacentHTML('afterbegin', this.template(data))
  },

  template(data) {
    return `<article class="post">
    <div class="post-header">
      <p>${data.user.name}</p>
    </div>
    <div class="post-body">
      <p>${data.body}</p>
    </div>
  </article>`
  }
});
