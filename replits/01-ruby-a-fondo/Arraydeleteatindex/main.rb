my_arr = *1..10
my_arr_copy = my_arr.clone

print my_arr
puts "\nSee what's going to happen next"
puts ""

# When the element in index 0 is deleted, the index of the whole array is changed. At first, 1 is index 0, but when it gets deleted from the array, now number 2 belongs to index 0 and becomes the "actual" element being iterated
# So, when the second iteration starts, what should be element in index 1 (number 2) is now element in initial index, number 3
my_arr.each_with_index do |i, ind|
  puts "Start: #{i} - Index: #{ind}"
  my_arr.delete_at(0)
  puts "End: #{i} - Index: #{ind}"
end

puts "\nDifferent and correct Approach"
puts ""
print my_arr_copy
puts ""

# Here, by using the actual index of the element, the missbehavior is corrected
my_arr_copy.each_with_index do |i, ind|
  puts "A - Start: #{i} - Index: #{ind}"
  my_arr.delete_at(ind)
  puts "D - End: #{i} - Index: #{ind}"
end

print my_arr_copy

# For more, see
#https://stackoverflow.com/questions/35499378/delete-element-of-array-while-iterating
#
#https://stackoverflow.com/questions/21213984/ruby-what-happens-when-i-delete-element-of-an-array-when-iterating-over-the-sam