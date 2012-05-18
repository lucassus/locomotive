module PostsController
  # Action is a common superclass for all the actions
  # inside `PostsController`.
  class Action < ApplicationController
    include FocusedController::Mixin
  end

  class Index < Action
    def run
      # Your code here.
    end

    # No instance variables are shared with the view. Instead,
    # public methods are defined.
    def posts
      @posts ||= Post.recent(5)
    end

    # To prevent yourself having to write `controller.posts`
    # in the view, you can declare the method as a helper
    # method which means that calling `posts` automatically
    # delegates to the controller.
    helper_method :posts
  end

  # Actions do not need to declare a `run` method - the default
  # implementation inherited from `FocusedController::Mixin` is an
  # empty method.
  class Show < Action
    # Here's a shorter way to declare a method that is also a
    # helper_method
    expose(:post) { Post.published.find(params[:id]) }
  end
end
