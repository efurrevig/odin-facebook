import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "moveTopButton" ]

    connect() {
        console.log('hello')
        const moveTopButton = this.moveTopButtonTarget;
        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 1500) {
                moveTopButton.classList.remove('hidden');
            } else {
                moveTopButton.classList.add('hidden');
            }
        })
    }

    moveUserToTop() {
        window.scrollTo(0, 0);
    }
}
