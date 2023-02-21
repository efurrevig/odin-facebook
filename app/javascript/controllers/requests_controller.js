import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "acceptFriend", "declineFriend", "check", "x" ]

    connect() {
        console.log("RequestsController connected")
    }

    accept() {
        this.acceptFriendTarget.classList.add("hidden")
        this.declineFriendTarget.classList.add("hidden")
        this.checkTarget.classList.remove("hidden")
    }

    decline() {
        this.acceptFriendTarget.classList.add("hidden")
        this.declineFriendTarget.classList.add("hidden")
        this.xTarget.classList.remove("hidden")
    }


    /* TODO:
            Transition to "accepted" or "declined" state
    */
}
