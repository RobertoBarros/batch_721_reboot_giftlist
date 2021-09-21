require 'csv'
require 'open-uri'
require 'nokogiri'

gifts = [] # gifts é um array de hashs

# Storing em Arquivo CSV
# (SOMENTE PARA AÇÕES QUE ALTERAM O ARRAY)
def save(gifts)
  CSV.open('gifts.csv','wb') do |csv|
    gifts.each do |gift|
      csv << [gift[:name], gift[:price], gift[:bought]]
    end
  end
end

# Parsing do Arquivo CSV
# (SOMENTE AO INICIAR O PROGRAMA)
def load(gifts)
  CSV.foreach('gifts.csv') do |row|
    name = row[0]
    price = row[1].to_i
    bought = row[2] == 'true'
    gift = { name: name, price: price, bought: bought }
    gifts << gift
  end
end

# LISTAR TODOS OS PRODUTOS DO ARRAY
def list(gifts)
  puts 'listar os itens'
  # Show gifts with index
  gifts.each_with_index do |gift, index|
    puts "#{index + 1} - #{gift[:bought] ? '[X]' : '[ ]'} - #{gift[:name]} - R$ #{gift[:price]}"

    # teste de impressão com casas decimais: {sprintf('%.2f', gift[:price])}"
  end
end

# ADICIONAR UM PRODUTO AO ARRAY
def add(gifts)
  puts 'Que item quer adicionar'
  name = gets.chomp

  puts 'Qual é o preço do item?'
  price = gets.chomp.to_i

  # O array "gifts" recebendo uma hash com chaves "name" e "price"
  # gifts = [{name: "brinquedo", price: 10}, {name: "iphone13", price: 9999}]
  gifts << { name: name, price: price, bought: false }
end

# REMOVER UM PRODUTO DO ARRAY
def delete(gifts)
  # Listar os items
  list(gifts)

  # Ask index of gift to delete
  puts "Qual é o item (número) a ser deletado?"
  index = gets.chomp.to_i - 1
  # Remove from array by index
  gifts.delete_at(index)
end

# MARCAR UM PRODUTO COMO COMPRADO
def mark(gifts)
  # List gifts
  list(gifts)

  # Ask gift index to mark as bought
  puts 'Qual marcar como comprado?'
  index = gets.chomp.to_i - 1

  # Mark as bought!
  gifts[index][:bought] = true
end

# SCRAPE DA AMAZON.COM.BR
def scrape(gifts)
  puts "Qual o produto para pesquisar?"
  product = gets.chomp

  url = "https://www.amazon.com.br/s?k=#{product}"

  html_text = URI.open(url).read
  html = Nokogiri::HTML(html_text)

  products = [] # Array de Hash com o nome e proço do produto da amazom
  html.search('.s-result-item').first(10).each do |card|
    name = card.search('h2').text.strip
    price = card.search('.a-price-whole').text.strip.delete('.').delete(',').to_i

    next if name == '' || price == '' # Ignora produtos que não possuem nome ou preço

    products << { name: name, price: price }
  end

  # Mostra os produtos ao usuário
  puts "Escolha qual produto importar:"
  products.each_with_index do |product, index|
    puts "#{index + 1} #{product[:name]} R$ #{product[:price]}"
  end

  puts "Entre com o número do produto:"
  index = gets.chomp.to_i - 1

  # Adiciona o produto selecionado no array de gifts
  gifts << { name: products[index][:name], price: products[index][:price], bought: false }
end


#########################################
# NOSSO PROGRAMA INICIA A PARTIR DAQUI!
#########################################

# Welcome message
puts 'Bem vindo, gaste seu dinheiro no reboot do Roberto'
# Show actions / Ask action

load(gifts) # Carrega os gifts do arquivo gifts.csv

loop do # Loop infito para perguntar o que o usuário quer fazer
  puts 'O que deseja fazer [list|add|mark|delete|scrape|quit]?'
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
  when 'mark'
    mark(gifts)
    save(gifts)
  when 'scrape'
    scrape(gifts)
    save(gifts)
  when 'quit'
    break
  else
    puts 'Ação não conhecida, veja o menu!!!!'
  end
end

# Exit / Goodbye Message
puts 'see you!'
