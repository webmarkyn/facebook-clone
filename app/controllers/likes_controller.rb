# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like, only: %i[show edit update destroy]

  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1
  # GET /likes/1.json
  def show; end

  # GET /likes/1/edit
  def edit; end

  # POST /likes
  # POST /likes.json
  def create
    @post = Post.find(params[:post_id])
    @user_id = current_user.id
    @like = @post.likes.build user_id: @user_id

    respond_to do |format|
      if @like.save
        format.html { redirect_to @post, notice: 'Like was successfully created.' }
      else
        format.html { redirect_to @post, alert: 'Something went wrong' }
      end
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Like was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
