class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :set_tags

  def index
    @notes = Note.all
  end

  def show; end

  def new
    @note = Note.new
  end

  def edit; end

  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_path, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_tags
    @tags = Tag.all
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, tag_ids: [])
  end
end
