class AllergiesController < ApplicationController

  def index
    client = ManaCloud.new('test4', 'test1234')
    @allergies =  []

    client.allergies.map do |record|
      record['entries'].map do |entry| 
        @allergies << {type: entry['allergy-type'], allergen: entry['allergen']}
      end
    end

  end

end



  