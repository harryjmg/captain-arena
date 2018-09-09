class ArenaController < ApplicationController
  def index
    @fights = Fight.all
    @characters = Character.all
  end
end
