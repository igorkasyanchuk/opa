ThinkingSphinx::Index.define :business, :with => :active_record do
  indexes name
  indexes synonims
  indexes description
  indexes categories.name
  indexes keywords.name
  indexes phones_addresses.address
  indexes phones_addresses.phone
end