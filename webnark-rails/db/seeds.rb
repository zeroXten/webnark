# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

report_categories = ReportCategory.create([
  { name: 'Authentication & Session Management', description: '....' },
  { name: 'Data at Rest', description: '....' },
])

report_items = ReportItem.create([
  { report_category_id: report_categories[0].id, name: 'Authentication Mechanisms' },
  { report_category_id: report_categories[0].id, name: 'Password Storage' },
  { report_category_id: report_categories[1].id, name: 'Data Encryption' },
  { report_category_id: report_categories[1].id, name: 'Data retention' },
])

report_choices = ReportChoice.create([
  { report_item_id: report_items[0].id, name: "Supports two-factor", bonus: false, points: 10 },
  { report_item_id: report_items[1].id, name: "Supports OpenID", bonus: false, points: 10 },
  { report_item_id: report_items[2].id, name: "Uses bcrypt", bonus: false, points: 10 },
  { report_item_id: report_items[2].id, name: "Plaintext", bonus: false, points: -20 },
  { report_item_id: report_items[2].id, name: "MD5", bonus: false, points: -10 },
])

services = Service.create([
  { name: 'Google Mail', description: '...' },
  { name: 'DropBox', description: '...' },
])

answers = Answer.create([
  { service_id: services[0].id, report_choice_id: report_choices[0].id, notes: "..." },
  { service_id: services[0].id, report_choice_id: report_choices[1].id, notes: "..." },
  { service_id: services[0].id, report_choice_id: report_choices[2].id, notes: "..." },
  { service_id: services[0].id, report_choice_id: report_choices[3].id, notes: "..." },
  { service_id: services[0].id, report_choice_id: report_choices[4].id, notes: "..." },
  { service_id: services[1].id, report_choice_id: report_choices[0].id, notes: "..." },
  { service_id: services[1].id, report_choice_id: report_choices[1].id, notes: "..." },
  { service_id: services[1].id, report_choice_id: report_choices[2].id, notes: "..." },
  { service_id: services[1].id, report_choice_id: report_choices[3].id, notes: "..." },
  { service_id: services[1].id, report_choice_id: report_choices[4].id, notes: "..." },
])
