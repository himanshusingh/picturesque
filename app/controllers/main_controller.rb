require 'prawn'
require "open-uri"
require 'rexml/document'
require 'json'
class MainController < ApplicationController
  def index
  end

  def upload

  	#For upload , we need these values
		options = {}
		options[:api_key] = 'duJ4P1CJ'
		options[:username] = 'apoorvik'
		options[:password] = "gemini86"
		options[:title] = params[:name] || 'SlideShare HACK Day 2013'
		options[:description] = params[:description] || 'Description for SlideShare HACK Day 2013'
		options[:filename] = "implicit.pdf"
		ts, hash = 1380734970, 'f6b2fea35eecbe0c8c11091d4f93500720076fff'
		image_hash = params[:images]
		# Create a pdf with image data
		Prawn::Document.generate("implicit.pdf",:skip_page_creation => true) do
			image_hash.each do |key , image_data|
				start_new_page(:size => [image_data["height"].to_i,image_data["width"].to_i],:margin => 0, :layout => :landscape)
				image open(image_data["source"]) , :width => image_data["width"].to_i, :height => image_data["height"].to_i
				if image_data["caption"]
					transparent(0.3) do 
						fill_color "000000"
						fill_rectangle([0,75], image_data["width"].to_i,50)
					end
					fill_color "FFFFFF"
					font_size 16
					text_box(image_data["caption"], :valign => :center, :align => :center,
											:at => [0,75], :width => image_data["width"].to_i, :height => 50) 
				end
			end
		end

		#api call for upload
		response = `curl --trace-ascii -o/dev/null -F "slideshow_srcfile=@#{options[:filename]}" -F "username=#{options[:username]}" -F "password=#{options[:password]}" -F "slideshow_title=#{options[:title]}" -F "description=#{options[:description]}" -F "api_key=#{options[:api_key]}" -F "hash=#{hash}" -F "make_src_public=N" -F "ts=#{ts}" "https://www.slideshare.net/api/2/upload_slideshow"`
		doc = REXML::Document.new(response)
		slideshowid_array=doc.get_elements('//SlideShowID')
		puts slideshowid_array
		render :json => {:slideshow_id => slideshowid_array[0].text}
  end

end
