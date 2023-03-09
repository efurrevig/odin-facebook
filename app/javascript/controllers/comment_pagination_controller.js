import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
    static values = {
        url: String,
        page: Number,
    };
    
    static targets = [ "lastPage", "seeMoreButton", "commentPagination" ];

    initialize() {
        this.click = this.click.bind(this);
        this.pageValue = this.pageValue || 1;
        this.requestInProgress = false;
    }

    connect() {
        this.seeMoreButtonTarget.addEventListener("click", this.click);
    }

    disconnect() {
        this.seeMoreButtonTarget.removeEventListener("click", this.click);
    }

    click() {
        if (!this.hasLastPageTarget && !this.requestInProgress) {
            this._fetchNewPage();
        }
    }

    async _fetchNewPage() {
        console.log('hello')
        this.requestInProgress = true;
        const url = new URL(this.urlValue);
        url.searchParams.set('page', this.pageValue)

        await get(url.toString(), {
            responseKind: 'turbo-stream'
        });
        this.pageValue +=1;
        this.requestInProgress = false;
    }

}
