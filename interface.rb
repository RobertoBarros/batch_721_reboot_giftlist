# Welcome message
puts 'Bem vindo, gaste seu dinheiro no reboot do Roberto'
# Show actions / Ask action
loop do
  puts 'O que deseja fazer [list|add|delete|quit]?'
  action = gets.chomp.downcase
# Execute action
  case action
  when 'list'
    puts 'listar os itens'
  when 'add'
    puts 'Que item quer adicionar'
  when 'delete'
    puts 'Que item quer apagar'
  when 'quit'
    break
  else
    puts 'Ação não conhecida, veja o menu!!!!'
  end
end
# Exit / Goodbye Message
puts 'see you!'
