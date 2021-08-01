module TestData

  # use to create consistent data
  # only need to call the method for the data wanted, as dependent tables call their parents
  # ex: want invoice_items -> TestData.invoice_items will call items and invoices
  # which will call their parents, creating all needed data

  def self.merchants
    [["Mr. Jone Runolfsdottir", 1],
    ["Weldon Barton DO", 1],
    ["Ewa Pollich", 1],
    ["Hermelinda Marvin", 1],
    ["Roberto Wolf",1]].each do |name|
      Merchant.create(name: name[0])
    end
    return "Merchants created"
  end
  def self.customers
    [["Lumos", "Slytherin"],
    ["Obliviate", "Pukwudgie"],
    ["Revelio", "Gryffindor"],
    ["Wingardium Leviosa", "Ravenclaw"],
    ["Crucio", "Slytherin"]].each do |name|
      Customer.create(first_name: name[0], last_name: name[1])
    end
    return "Customers created"
  end
  def self.items
    merchants
    # attributes = []
    # merch_id_start = Merchant.first.id
    # merch_id_end = Merchant.last.id
    # 12.times do
    #   attributes << [Faker::Movies::HarryPotter.character, Faker::TvShows::BojackHorseman.quote, rand(100..10000), rand(0..1).round, rand(merch_id_start..merch_id_end)]
    # end
    [["Madam Rosmerta", "You know what the problem is with everybody? They all just want to hear what they already believe. No one ever wants to hear the truth", 8363, 0,Merchant.first.id],
    ["Mary Cattermole", "Beer before liquor, never sicker, liquor before beer, never fear, don't do heroin", 1177, 0, Merchant.first.id],
    ["Sirius Black", "Yes, I ate all the muffins, because I have no self-control and I hate myself", 4960, 0, Merchant.first.id],
    ["Susan Bones", "I do love you, by the way. I mean as much as I'm capable of loving anyone", 7433, 1, Merchant.first.id],
    ["Ignotus Peverell", "Yes, I ate all the muffins, because I have no self-control and I hate myself", 3985, 1, Merchant.all[1].id],
    ["James Potter","The universe is a cruel, uncaring void. The key to being happy isn't a search for meaning. It's to just keep yourself busy with unimportant nonsense, and eventually, you'll be dead",8772,0,Merchant.all[1].id],
    ["Mr. Borgin", "Yes, I ate all the muffins, because I have no self-control and I hate myself", 2036, 1, Merchant.all[1].id],
    ["Petunia Dursley", "Dead on the inside, dead on the outside", 1788, 0, Merchant.all[1].id],
    ["Minerva McGonagall","The universe is a cruel, uncaring void. The key to being happy isn't a search for meaning. It's to just keep yourself busy with unimportant nonsense, and eventually, you'll be dead",9703,0,Merchant.all[2].id],
    ["Fred Weasley", "For a lot of people, life is just one long, hard kick in the urethra", 5473, 0, Merchant.all[2].id],
    ["Cho Chang", "Ow, crap. I hate this. Running is terrible. Everything is the worst", 6559, 1, Merchant.all[2].id],
    ["Dennis Creevey","The universe is a cruel, uncaring void. The key to being happy isn't a search for meaning. It's to just keep yourself busy with unimportant nonsense, and eventually, you'll be dead",7777,0,Merchant.all[2].id],
    ["Nagini", "It gets easier. But you have to do it every day, that's the hard part. But it does get easier", 3461, 0, Merchant.all[3].id],
    ["Alicia Spinnet", "Ow, crap. I hate this. Running is terrible. Everything is the worst", 6765, 1, Merchant.all[3].id],
    ["Percy Weasley", "It gets easier. But you have to do it every day, that's the hard part. But it does get easier", 9602, 1, Merchant.all[3].id],
    ["Ernie Macmillan", "Ow, crap. I hate this. Running is terrible. Everything is the worst", 4108, 1, Merchant.all[3].id],
    ["Lee Jordan", "Dead on the inside, dead on the outside", 1508, 0, Merchant.all[4].id],
    ["Dudley Dursley", "Spaghetti or not, here I come", 3168, 0, Merchant.all[4].id],
    ["Narcissa Malfoy", "It gets easier. But you have to do it every day, that's the hard part. But it does get easier", 5612, 1, Merchant.all[4].id],
    ["Cho Chang", "Dead on the inside, dead on the outside", 8263, 1, Merchant.all[4].id]].each do |item_attr|
      Item.create!(name: item_attr[0], description: item_attr[1] , unit_price: item_attr[2], merchant_id: item_attr[4] )
    end
    return "Items created"
  end
  def self.invoices
    customers
    status = [0, 1, 0, 2, 2, 0, 0, 1, 2, 0, 2, 2, 1, 2, 2, 1, 1, 1, 1, 1]
    i = 0
    # 25.times do
    #   attributes << rand(0..2)
    # end
    Customer.all.each do |customer|
      4.times do
        customer.invoices.create(status: status[i])
        i += 1
      end
    end
    return "Invoices created"
  end
  def self.invoice_items
    items
    items = Item.all
    invoices
    inv_item_attrs = [[11, 1000, 1],[9, 2946, 2],[15, 2530, 0],[5, 2841, 2],[15, 6880, 1],[6, 1058, 0],[8, 503, 0],[10, 1045, 2],[15, 3468, 1],
    [3, 9558, 0],[10, 6317, 2],[9, 7425, 2],[7, 6480, 2],[2, 2845, 1],[9, 8777, 2],[13, 4760, 2],[14, 6326, 1],[5, 7216, 2],
    [15, 9942, 0],[2, 8728, 1],[15, 4406, 1],[2, 5485, 2],[13, 7322, 0],[11, 7028, 2],[7, 849, 2],[9, 8722, 2],[5, 1155, 0],[9, 1042, 0],
    [11, 8182, 1],[10, 5436, 2],[1, 8788, 1],[11, 9770, 2],[14, 6158, 2],[12, 7598, 2],[13, 2860, 0],[4, 3735, 2],[1, 6548, 2],[14, 2126, 2],
    [8, 6073, 1],[3, 7771, 2],[12, 2425, 1],[4, 5002, 0],[3, 2414, 0],[7, 4143, 0],[13, 8595, 0],[12, 6128, 0],[9, 7925, 1],[11, 5749, 0],
    [1, 7386, 0],[10, 8114, 0],[2, 6992, 1],[11, 6954, 0],[7, 3981, 0],[12, 6354, 2], [2, 8134, 1], [13, 3159, 1], [8, 2583, 2], [15, 608, 0],
    [10, 3071, 2], [5, 8350, 1]]
    i = 0
    j = 0
    Invoice.all.each do |invoice|
      k = 0
      3.times do
        invoice.invoice_items.create!(quantity: inv_item_attrs[j][0], unit_price: ( i + k >= 19) ? items[i - k].unit_price : items[i + k].unit_price, status: inv_item_attrs[j][2], item_id:( i + k >= 19) ? items[i - k].id : items[i + k].id)
        j += 1
        k += 1
      end
      i += 1
    end
    return "Invoice Items created"
  end

  def self.transactions
    invoices
    i = 0
    attrs = [['6709157746197025', 1],
             ['5058572322741234', 1],
             ['3589-7998-3163-0215', 0],
             ['6759-7888-1328-8020', 1],
             ['4167-6764-8692-1248', 0],
             ['3735-198691-16788', 0],
             ['6007-2281-2123-8478', 1],
             ['6759-8340-5078-4752', 1],
             ['3444-573890-81420', 0],
             ['6304703995860629', 1],
             ['3529-6358-6128-3058', 1],
             ['6767-6932-4805-7346', 1],
             ['3529-6924-9903-8172', 1],
             ['4501-8843-4171-8008', 1],
             ['3733-214867-27943', 1],
             ['3682-234983-33301', 1],
             ['5019-6258-9345-3110', 1],
             ['3459-356941-96032', 1],
             ['5019-3271-4263-9595', 1],
             ['3474-491384-02517', 0],
             ['3689-590075-01920', 1],
             ['6767-2857-2835-7577', 1],
             ['5127-0556-6671-6288', 1],
             ['6304793926193959', 1],
             ['6771292980843368', 1]]

    Invoice.all.each do |invoice|
      invoice.transactions.create!(credit_card_number: attrs[i][0]
                          .delete('-')[0..15],result: attrs[i][1] )
      i += 1
    end
    return 'Transactions created'
  end
end
