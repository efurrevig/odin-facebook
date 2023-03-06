import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "moveTopButton" ]

    connect() {
        window.addEventListener('scroll', this.scrollHandler.bind(this));
    }
    
    disconnect() {
        window.removeEventListener('scroll', this.scrollHandler.bind(this));
    }

    scrollHandler() {
        const moveTopButton = this.moveTopButtonTarget;
        const yOffset = window.innerHeight * 0.8;
        if (window.pageYOffset > yOffset) {
            moveTopButton.classList.remove('hidden');
        } else {
            moveTopButton.classList.add('hidden');
        }
    }

    moveUserToTop() {
        window.scrollTo(0, 0);
    }
}
