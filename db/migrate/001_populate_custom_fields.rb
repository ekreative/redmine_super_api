class PopulateCustomFields < ActiveRecord::Migration
  def self.up
    if CustomField.find_by_name('IOS').nil?
      ProjectCustomField.create(name: 'IOS', default_value: 0, field_format: 'bool', is_filter: true, format_store: {edit_tag_style: 'check_box'})
    end
    if CustomField.find_by_name('Android').nil?
      ProjectCustomField.create(name: 'Android', default_value: 0, field_format: 'bool', is_filter: true, format_store: {edit_tag_style: 'check_box'})
    end
  end

  def self.down
    CustomField.find_by_name('IOS').delete unless CustomField.find_by_name('IOS').nil?
    CustomField.find_by_name('Android').delete unless CustomField.find_by_name('Android').nil?
  end
end