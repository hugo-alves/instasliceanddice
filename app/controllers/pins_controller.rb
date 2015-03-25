class PinsController < ApplicationController


  def new
  end

  def create
  end

  def show
  end

  def fromlink
	    require "net/http"
	    require 'RMagick'


	    #saca so o fim do url da foto que o user colou, para usar no pedido do oembed
	    @short = URI(params[:q]).path.split('/').last
	    @pissa = URI(params[:p]).path.split('/').last

	    #junta tudo para ter o url directo da foto com tamanho grande
	    @short = 'https://instagram.com/p/' + @short + '/media/?size=l'
	    @pissa = 'https://instagram.com/p/' + @pissa + '/media/?size=l'

	    #CORTA AS FATIAS DA PRIMEIRA IMAGEM E GUARDA-A NO DISCO
	    for i in 0..3
	      @image = MiniMagick::Image.open(@short)
	      @image.crop("160x640+#{i * 160}+0")
	      @image.write "app/assets/images/cone" + i.to_s() + ".png"
	    end

	    #CORTA AS FATIAS DA SEGUNDA IMAGEM E GUARDA-A NO DISCO
	    for i in 0..3
	      @image = MiniMagick::Image.open(@pissa)
	      @image.crop("160x640+#{i * 160}+0")
	      @image.write "app/assets/images/cilindro" + i.to_s() + ".png"
	    end

	    #JUNTA AS FATIAS DAS DUAS IMAGENS NUMA NOVA E GUARDA-A NO DISCO
	    @nomedaimagem = rand.to_s
	    image_list = Magick::ImageList.new( "app/assets/images/cone0.png", "app/assets/images/cilindro0.png", "app/assets/images/cone1.png", "app/assets/images/cilindro1.png", "app/assets/images/cone2.png", "app/assets/images/cilindro2.png", "app/assets/images/cone3.png", "app/assets/images/cilindro3.png" )
	    image_list.append(false).write("app/assets/images/images.png")
	    Cloudinary::Uploader.upload("app/assets/images/images.png", :public_id => "#{@nomedaimagem}", :folder => "finais", :invalidate => true)
  end
  
end



