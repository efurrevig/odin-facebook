import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "login", "register", "registerButton", "loginButton" ]

    displayLogin() {
      this.loginTarget.classList.remove("hidden")
      this.loginButtonTarget.classList.add("active")
      this.registerTarget.classList.add("hidden")
      this.registerButtonTarget.classList.remove("active")
    }

    displayRegister() {
      this.loginTarget.classList.add("hidden")
      this.loginButtonTarget.classList.remove("active")
      this.registerTarget.classList.remove("hidden")    
      this.registerButtonTarget.classList.add("active")    
    }
  }