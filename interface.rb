# Welcome message
puts 'Bem vindo, gaste seu dinheiro no reboot do Roberto'
# Show actions / Ask action
gifts = []

def list(gifts)
  puts 'listar os itens'
  # Show gifts with index
  gifts.each_with_index do |gift, index|
    puts "#{index + 1} - #{gift}"
  end
end

def add(gifts)
  puts 'Que item quer adicionar'
  item_add = gets.chomp
  gifts << item_add
end

def delete(gifts)
  # Listar os items
  list(gifts)

  # Ask index of gift to delete
  puts "Qual é o item (número) a ser deletado?"
  index = gets.chomp.to_i - 1 
  
  # Remove from array by index
  gifts.delete_at(index)

end

loop do
  puts 'O que deseja fazer [list|add|delete|quit]?'
  action = gets.chomp.downcase
# Execute action
  case action
  when 'list'
    list(gifts)
  when 'add'
    add(gifts)
  when 'delete'
    delete(gifts)
  when 'quit'
    break
  else
    puts 'Ação não conhecida, veja o menu!!!!'
  end
end
# Exit / Goodbye Message
puts 'see you!'
