# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
    redirect_to posts_path
  end
end
