# coding: utf-8
class ComparacionesController < ApplicationController

  def new
    @comparacion = Comparacion.new  
    @idiomas = Comparacion::Idiomas.map{|k,v| [v,k]}
  end

  def show
    @comparacion = Comparacion.find(params['id'])
    @freqs_diff = @comparacion.freqs_diff
  end

  def create
    @comparacion = Comparacion.new(params[:comparacion])
    if @comparacion.save
      redirect_to @comparacion
    else
      flash[:error] = 'Hubo un problema guardando la comparación'
      render :new
    end
  end
end
