User.create({email: 'test@test.com', password: 'test123', first_name: 'John', last_name: 'Doe'})

vacay = Project.create({name: 'Vacation', user_id: 1})
toolman = Project.create({name: 'Home Improvement', user_id: 1})

vacay.tasks.create([{text: 'Book flights'}, {text: 'Book hotel'}, {text: 'Rent car'}, {text: 'Create itinerary'}])

toolman.tasks.create([{text: 'Fix kitchen sink'}, {text: 'Paint fence'}, {text: 'Grout bathroom tile'}, {text: 'Replace furnace'}, {text: 'Resurface countertops'}])
