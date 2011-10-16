def print_slices(arr, slice=4)
  acc = []
  arr.each do |a|
    acc.push(a)
    if acc.length == slice
      p acc
      acc = []
    end
  end
  p acc if acc.length > 0
end

print_slices(1..18)

def print_each_slice(arr, slice=4)
  arr.each_slice(4) { |a| p a }
end

print_each_slice(1..18)
