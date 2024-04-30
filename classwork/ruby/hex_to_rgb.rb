def hex_to_rgb(hex)
    r = hex.slice(1, 2).hex
    g = hex.slice(3, 2).hex
    b = hex.slice(5, 2).hex
    "rgb(#{r}, #{g}, #{b})" # implicit return, since it's the last line
end

puts hex_to_rgb("#FF99CC")