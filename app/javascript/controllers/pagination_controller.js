import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
    static values = {
        url: String,
        page: Number,
    };

    static targets = ["lastPage"];
    initialize() {
        this.scroll = this.scroll.bind(this);
        this.pageValue = this.pageValue || 1;
        this.requestInProgress = false;
    }

    connect() {
        document.addEventListener("scroll", this.scroll);
    }

    disconnect() {
        document.removeEventListener("scroll", this.scroll);
    }

    scroll() {
        if (this.scrollReachedEnd && !this.hasLastPageTarget && !this.requestInProgress) {
            this._fetchNewPage();
        }
    }

    async _fetchNewPage() {
        this.requestInProgress = true;
        const url = new URL(this.urlValue);
        url.searchParams.set('page', this.pageValue)

        await get(url.toString(), {
            responseKind: 'turbo-stream'
        });

        this.pageValue +=1;
        this.requestInProgress = false;
    }

    get scrollReachedEnd() {
        const { scrollHeight, scrollTop, clientHeight } = document.documentElement;
        const distanceFromBottom = scrollHeight - scrollTop - clientHeight;
        return distanceFromBottom < 10; 
    }
}