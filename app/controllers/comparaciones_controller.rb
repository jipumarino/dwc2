class ComparacionesController < ApplicationController

  def new
    @comparacion = Comparacion.new  
  end

  def create
   @freqs1 = get_freqs get_tagged params[:file1][:tempfile].path
   @freqs2 = get_freqs get_tagged params[:file2][:tempfile].path
   @df1a2 = get_freqs_diff @freqs1, @freqs2
   @df2a1 = get_freqs_diff @freqs2, @freqs1
  end
end
