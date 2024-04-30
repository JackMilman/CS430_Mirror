$old_number = 2
def random
    new_number = (3 * $old_number + 5) % 7
    $old_number = new_number
    new_number
end

for i in 0...8
    puts random
end