require "rails_helper"
#require "factory_bot"


	describe Person, type: :model  do
		context 'validation test' do
			let(:person) {build(:person)}
			#let(:person) {build(:random_person, first_name :'tacos')}
			it ' first name presence' do
				person = Person.new().save
				#puts 'person.last_name'
				expect(person.firstname).to eq(false)
			end
=begin
			it ' last name presence' do
				#puts person.last_name
				
				person = Person.new(lastname:'last', firstname: "njndn").save
				#person.firstname = 'aaaa'
				expect(person).to eq(false)
			end
			it ' civilité presence' do
				#puts person.last_name
				
				person = Person.new(lastname:'last', firstname: "njndn").save
				#person.firstname = 'aaaa'
				expect(person).to eq(false)
			end
=end
		end
	end