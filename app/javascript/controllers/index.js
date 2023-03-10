// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ButtonController from "./button_controller"
application.register("button", ButtonController)

import CommentPaginationController from "./comment_pagination_controller"
application.register("comment-pagination", CommentPaginationController)

import FormController from "./form_controller"
application.register("form", FormController)

import FriendsController from "./friends_controller"
application.register("friends", FriendsController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NewPostsController from "./new_posts_controller"
application.register("new-posts", NewPostsController)

import PaginationController from "./pagination_controller"
application.register("pagination", PaginationController)

import RequestsController from "./requests_controller"
application.register("requests", RequestsController)

import ToggleController from "./toggle_controller"
application.register("toggle", ToggleController)
