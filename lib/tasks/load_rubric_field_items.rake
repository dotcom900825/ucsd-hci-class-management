require "csv"

task :load_rubric_field_items, [:assignment] => :environment do |t, args|
  rubric_fields = RubricField.where(:assignment=>Assignment.find(args[:assignment])).order(:id)
  position = 1
  CSV.foreach(File.expand_path("../rubric_field_items_#{args[:assignment]}.csv", __FILE__)) do |row|
    field_name = row[0].strip
    item_name = row[1].strip
    point = row[2].strip

    field = rubric_fields.find_by(:name=>field_name)
    next if field.nil?

    item = field.rubric_field_items.find_by(:name=>item_name)
    item = field.rubric_field_items.create(:name=>item_name, :point=>point.to_i) if item.nil?

    item.update(:item_position=>position)
    position += 1

    # TODO: delete field and item if doesn't exist in csv
  end
end
