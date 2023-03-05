import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "newPostsButton", "postDisplay", "newPosts" ]

    observer = new MutationObserver((mutationsList) => {
        for (let mutation of mutationsList) {
            if (mutation.type === 'childList') {
                // Check if the hidden div is empty
                if (this.newPostsTarget.children.length === 0) {
                // Add the "hidden" class if the hidden div is empty
                    this.newPostsButtonTarget.classList.add('hidden');
                } else {
                // Show the "New Posts" button when new posts are added
                    this.newPostsButtonTarget.classList.remove('hidden');
                }
            }
        }
    })

    config = { attributes: true, childList: true, subtree: true };

    connect() {
        this.observer.observe(this.newPostsTarget, this.config);
    }

    showNewPosts() {
        const newPosts = this.newPostsTarget
        const postDisplay = this.postDisplayTarget
        while (newPosts.firstChild) {
            postDisplay.insertBefore(newPosts.lastChild, postDisplay.firstChild);
        }
        window.scrollTo(0, 0);
    }
}
