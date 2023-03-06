import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "friend", "unfriendButton" ]
    
  connect() {
    this.unfriendButtonTarget.addEventListener("ajax:success", this.removeFriend.bind(this));
  }

  disconnect() {
    this.unfriendButtonTarget.removeEventListener("ajax:success", this.removeFriend.bind(this));
  }
  
  removeFriend(event) {
    this.friendTarget.remove()
  }
}
