User.create({email: 'test@test.com', password: 'test123', first_name: 'John', last_name: 'Doe'})

Project.create({name: 'Vacation', user_id: 1})
Project.create({name: 'Home Improvement', user_id: 1})

Task.create({text: 'Book flights', project_id: 1})
Task.create({text: 'Book hotel', project_id: 1})
Task.create({text: 'Create itinerary', project_id: 1})
