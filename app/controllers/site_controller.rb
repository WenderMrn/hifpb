class SiteController < ApplicationController

  before_action :set_semester, :set_days

  def index
  end

  private
  def set_semester
    @current_semester = Semester.where(status: true).last
  end

  def set_days
    @days = ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta']
  end
end
