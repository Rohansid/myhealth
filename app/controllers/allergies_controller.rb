class AllergiesController < ApplicationController

  def index
    client = ManaCloud.new('ijones', 'mana')
    @allergies =  []

    client.allergies.map do |record|
      record['entries'].map do |entry| 
        @allergies << {type: entry['allergy-type'], allergen: entry['allergen']}
      end
    end

  end

end



  