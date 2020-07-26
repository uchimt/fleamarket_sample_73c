# 服のサイズ
clothessize_child_array = ['XXS以下','XS(SS)','S','M','L','XL(LL)','2XL(3L)','3XL(4L)','4XL(5L)以上','FREE SIZE']

parent = Size.create(size: '服のサイズ')
clothessize_child_array.each_with_index do |child, i|
  child = parent.children.create(size: child)
end

# レディース靴のサイズ
ladyshoesize_child_array = ['20cm以下','20.5cm','21cm','21.5cm','22cm','22.5cm','23cm','23.5cm','24cm','24.5cm','25cm','25.5cm','26cm','26.5cm','27cm','27.5cm以上']

parent = Size.create(size: 'レディース靴のサイズ')
ladyshoesize_child_array.each_with_index do |child, i|
  child = parent.children.create(size: child)
end

# メンズ靴のサイズ
menshoesize_child_array = ['23.5cm以上','24cm','24.5cm','25cm','25.5cm','26cm','26.5cm','27cm','27.5cm','28cm','28.5cm','29cm','29.5cm','30cm','30.5cm','31cm以上']

parent = Size.create(size: 'メンズ靴のサイズ')
menshoesize_child_array.each_with_index do |child, i|
  child = parent.children.create(size: child)
end

# キッズ服のサイズ　〜95cm
kidclosesmallsize_child_array = ['60cm','70cm','80cm','90cm','95cm']

parent = Size.create(size: 'キッズ服のサイズ　〜95cm')
kidclosesmallsize_child_array.each_with_index do |child, i|
  child = parent.children.create(size: child)
end

# キッズ服のサイズ　100cm〜
kidcloseslargesize_child_array = ['100cm','110cm','120cm','130cm','140cm','150cm','160cm']

parent = Size.create(size: 'キッズ服のサイズ　100cm〜')
kidcloseslargesize_child_array.each_with_index do |child, i|
  child = parent.children.create(size: child)
end

# キッズ靴のサイズ
kidshoesize_child_array = ['10.5cm以下','11cm・11.5cm','12cm・12.5cm','13cm・13.5cm','14cm・14.5cm','15cm・15.5cm','16cm・16.5cm','17cm・17.5cm']

parent = Size.create(size: 'キッズ靴のサイズ')
kidshoesize_child_array.each_with_index do |child, i|
  child = parent.children.create(size: child)
end

# タイヤのサイズ
tiresize_child_array = ['12インチ','13インチ','14インチ','15インチ','16インチ','17インチ','18インチ','19インチ','20インチ','21インチ','22インチ','23インチ','24インチ']

parent = Size.create(size: 'タイヤのサイズ')
tiresize_child_array.each_with_index do |child, i|
  child = parent.children.create(size: child)
end