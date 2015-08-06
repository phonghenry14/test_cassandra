class NotesController < ApplicationController
  def show
     @note = Note.find_by_id params[:id]
  end

  def create
    if params[:url].present?
      @note = Note.get_note params[:url]
      unless @note.title == ""
        flash[:success] = "Create note successfully"
        redirect_to note_path @note
      else
        flash[:danger] = "Create note failed"
        render :new
      end
    else
      flash[:danger] = "URL can't be blank"
      render :new
    end
  end
end
