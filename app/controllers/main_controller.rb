#require 'prawn'
#require "open-uri"
class MainController < ApplicationController
  def index
  end

  def upload

  	#For upload , we need these values
		options = {}
		options[:api_key] = 'duJ4P1CJ'
		options[:username] = 'apoorvik'
		options[:password] = '***'
		options[:title] = params[:title] || 'SlideShare HACK Day 2013'
		options[:description] = params[:description] || 'Description for SlideShare HACK Day 2013'
		options[:filename] = "#{title}" + rand(100).to_s
		options[:filename] = options[:filename][0...10] + ".pdf"
		ts, hash = 1380734970, 'f6b2fea35eecbe0c8c11091d4f93500720076fff'

		# Create a pdf with image data
		Prawn::Document.generate("implicit.pdf",
                     :page_layout => :landscape) do

			#create first slide start

			#create first slide end
			params[:images].each do | key , image_data |
				image open(image_data[:source])
				transparent(0.4) do 
  				fill_color "000000"
  				fill_rectangle([0,75], 720,50)
				end
				text_box image_data[:caption], :valign => :center, :align => :center,
 									:at => [0,75], :width => 720, :height => 50
 				start_new_page
			end
		end

		#api call for upload
		`curl --trace-ascii -o/dev/null -F "slideshow_srcfile=@#{options[:filename]}" -F "username=#{options[:username]}" -F "password=#{options[:password]}" -F "slideshow_title=#{options[:title]}" -F "description=#{options[:description]}" -F "api_key=#{options[:api_key]}" -F "hash=#{hash}" -F "make_src_public=N" -F "make_slideshow_private=Y" -F "ts=#{ts}" "https://www.slideshare.net/api/2/upload_slideshow"`

  end

end
