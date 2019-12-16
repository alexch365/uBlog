# frozen_string_literal: true

class UsersController < ApplicationController
  def co_authors
    render json: UsersCoAuthorsQuery.execute
  end
end
