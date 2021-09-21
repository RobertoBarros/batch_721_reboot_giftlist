require 'csv'

# Welcome message
puts 'Bem vindo, gaste seu dinheiro no reboot do Roberto'
# Show actions / Ask action
gifts = []

def save(gifts)
  CSV.open('gifts.csv','wb') do |csv|
    gifts.each do |gift|
      csv << [gift[:name], gift[:price]]
    end
  end
end

def load(gifts)
  CSV.foreach('gifts.csv') do |row|
    name = row[0]
    price = row[1].to_i
    gift = { name: name, price: price }
    gifts << gift
  end
end


def list(gifts)
  puts 'listar os itens'
  # Show gifts with index
  gifts.each_with_index do |gift, index|
    puts "#{index + 1} - #{gift[:name]} - R$ #{gift[:price]}"

    # teste de impressão com casas decimais: {sprintf('%.2f', gift[:price])}"
  end
end

def add(gifts)
  puts 'Que item quer adicionar'
  name = gets.chomp

  puts 'Qual é o preço do item?'
  price = gets.chomp.to_i

  # O array "gifts" recebendo uma hash com chaves "name" e "price"
  # gifts = [{name: "brinquedo", price: 10}, {name: "iphone13", price: 9999}]
  gifts << {name: name, price: price}
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

load(gifts)

loop do
  puts 'O que deseja fazer [list|add|delete|quit]?'
  action = gets.chomp.downcase
# Execute action
  case action
  when 'list'
    list(gifts)
  when 'add'
    add(gifts)
    save(gifts)
  when 'delete'
    delete(gifts)
    save(gifts)
  when 'quit'
    break
  else
    puts 'Ação não conhecida, veja o menu!!!!'
  end
end
# Exit / Goodbye Message
puts 'see you!'
