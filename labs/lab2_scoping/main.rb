#!usr/bin/env ruby

# Jack Milman

require_relative './html.rb'

tag_1 = Html.make_tag("img", {src: "bernie.jpg"}, :empty) 
puts tag_1
tag_2 = Html.make_tag('div', {id: 'root', class: 'frame'}, :sandwich) 
puts tag_2
tag_3 = Html.make_tag('Gallery', {}, :selfclose)
puts tag_3
tag_4 = Html.make_tag('new_type1', {id: 'tag', class: 'new_type', new_attr: 'attribute_new'}, :selfclose) 
puts tag_4
tag_5 = Html.make_tag('empty_block', {}, :empty)
puts tag_5
tag_6 = Html.make_tag('sad_sandwich', {}, :sandwich)
puts tag_6
tag_7 = Html.make_tag('user_info', {username: 'Xx_C00L_N4M3_xX', password: 'password123'}, :empty)
puts tag_7