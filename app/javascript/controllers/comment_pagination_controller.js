import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
    static values = {
        url: String,
        page: Number
    };

    connect() {
        this.element.textContent = "Hello World!"
    }
}
