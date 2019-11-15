# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    redirect_to new_user_session_path
  end
end
