import consumer from "./consumer"

const postChannel = consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const postDisplay = document.querySelector('#post-display')
    postDisplay.insertAdjacentHTML('afterbegin', this.template(data))
  },

  template(data) {
    return `<div class="container mt-5 mb-5">
              <div class="row d-flex align-items-center justify-content-center">
                  <div class="col-md-6">
                      <div class="card shadow p-3 rounded">
                          <div class="d-flex justify-content-between p-2">
                              <div class="d-flex flex-row align-items-center"> 
                                  <img src="assets/profile-pic.jpg" width="40em" height="40em" class="me-1 rounded-circle">
                                  <div class="d-flex flex-column ml-2"> 
                                      <span class="font-weight-bold">${data.user.name}</span>
                                  </div>
                              </div>
                              <div class="d-flex flex-row mt-1"> 
                                  <small class="mr-2">${data.created_at} ago</small> 
                                  <i class="bi bi-three-dots"></i> 
                              </div>
                          </div>
                          <div class="p-2">
                              <p class="text-justify">${data.body}</p>
                              <hr>
                              <!-- LIKE/DISLIKE -->
                              <div class="d-flex justify-content-between align-items-center">
                                  <div class="d-flex flex-row">
                                      <form>
                                          <input type="hidden" name="status" value="true">
                                          <button class="like-button">
                                              <i class="bi bi-hand-thumbs-up-fill me-1"></i>
                                          </button>
                                          <small class="me-2">${data.like_count}</small>
                                      </form>
                                      <form>
                                          <input type="hidden" name="status" value="false">
                                          <button class="like-button">
                                              <i class="bi bi-hand-thumbs-down-fill me-1"></i>
                                          </button>
                                          <small>${data.dislike_count}</small>
                                      </form>
                                  </div>
                                  <div class="d-flex flex-row muted-color"> <span>0 comments</span> </div>
                              </div>
                              <hr>
                              <div class="comments" id="post-${data.id}-comments">
                                <div class="comment-input">
                                    <form class="form-inline" action="/posts/:${data.id}/comments" method="post">
                                        <div class="form-group">
                                            <input type="text" name="body" class="form-control">
                                        </div>
                                        <div class="form-group">
                                            <input type="submit" value="Comment" class="btn btn-primary mt-2">
                                        </div>
                                    </form>
                                </div>
                              </div>
                            </div>
                        </div>
                  </div>
              </div>
            </div>`
    }
  });
