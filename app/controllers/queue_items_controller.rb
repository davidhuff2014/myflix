class QueueItemsController < ApplicationController
before_filter :require_user
# TODO Hw2-5 Solution 10:57 go from here
  def index
    @queue_items = current_user.queue_items
  end
end
