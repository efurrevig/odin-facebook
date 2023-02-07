import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "login", "register" ]

    displayLogin() {
      this.loginTarget.classList.remove("hidden")
      this.registerTarget.classList.add("hidden")  
    }

    displayRegister() {
      this.loginTarget.classList.add("hidden")
      this.registerTarget.classList.remove("hidden")        
    }
  }