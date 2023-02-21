import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {
        console.log("RequestsController connected")
    }

    accept() {
        console.log("accept")
    }

    decline() {
        console.log("decline")
    }

}
