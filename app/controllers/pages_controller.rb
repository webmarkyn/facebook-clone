# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    render :layout => false
  end
end
