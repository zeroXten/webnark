report_categories = ReportCategory.create([
  {
    name: 'Authentication', 
    description: 'Authentication is proving you are who you say you are and session management is the process of maintaining that trust once established. Most website and services require you to register your details and then log in to use the service, often using a username and password.',
    icon_url: 'icons/Buzz-Private-icon.png' 
  },
  {
    name: 'Data at Rest',
    description: 'Refers to inactive data which is stored physically in any digital form (e.g. harddisk, USB drive, CDs and DVDs etc.).',
    icon_url: 'icons/It-Infrastructure-Hdd-icon.png'
  },
  {
    name: 'Data in Motion',
    description: 'Lorem ipsum dolor sit amet, consectvestibulum. Curabitur malesuada magna dapibus sapien faucibus, et rhoncus ligula sodales. Nam nibh massa, elementum vitae tincidunt placerat, semper et dolor. Donec blandit ut enim eu bibendum. Vestibulum id tincidunt velit.',
    icon_url: 'icons/It-Infrastructure-Remote-working-icon.png'
  },
  {
    name: 'Privacy & EULA',
    description: 'sapien faucibus, et rhoncus ligula sodales. Nam nibh massa, elementum vitae tincidunt placerat, semper et dolor. Donec blandit ut enim eu bibendum. Vestibulum id tincidunt velit.',
    icon_url: 'icons/Buzz-Visible-icon.png'
  },
  {
    name: 'Disclosure',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut lobortis eros, at faucibus sem. Maecenas in metus iaculis, fermentum enim a, dapibus quam. Praesent magna ante, elementum eu aliquet vitae, dignissim et justo. Phasellus convallis ligula vel libero euismod vestibulum. Curabitur malesuada magna dapibus sapien faucibus, et rhoncus ligula sodales. Nam nibh massa, elementum vitae tincidunt placerat, semper et dolor. Donec blandit ut enim eu bibendum. Vestibulum id tincidunt velit.',
    icon_url: 'icons/Users-Talk-icon.png'
  },
  {
    name: 'Advertising',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut lobortis eros, at faucibus sem. Maecenas in metus iaculis, fermentum enim a, dapibus quam. Praesent magna ante, elementum eu aliquet vitae, dignissim et justo. Phasellus convallis ligula vel libero euismod vestibulum. Curabitur malesuada magna dapibus sapien faucibus, et rhoncus ligula sodales. Nam nibh massa, elementum vitae tincidunt placerat, semper et dolor. Donec blandit ut enim eu bibendum. Vestibulum id tincidunt velit.',
    icon_url: 'icons/Business-Money-bag-icon.png'
  },
  {
    name: 'Incident History',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut lobortis eros, at faucibus sem. Maecenas in metus iaculis, fermentum enim a, dapibus quam. Praesent magna ante, elementum eu aliquet vitae, dignissim et justo. Phasellus convallis ligula vel libero euismod vestibulum. Curabitur malesuada magna dapibus sapien faucibus, et rhoncus ligula sodales. Nam nibh massa, elementum vitae tincidunt placerat, semper et dolor. Donec blandit ut enim eu bibendum. Vestibulum id tincidunt velit.',
    icon_url: 'icons/Office-Stuff-Planner-icon.png'
  },
])

report_items = ReportItem.create([
  # Authentication & Session Maintenance
  { 
    report_category_id: report_categories[0].id, 
    name: 'Design and Documentation'
  },
  { 
    report_category_id: report_categories[0].id, 
    name: 'Authentication Mechanisms' 
  },
  { 
    report_category_id: report_categories[0].id, 
    name: 'Password Policy' 
  },
  { 
    report_category_id: report_categories[0].id, 
    name: 'Password reset methods' 
  },
  { 
    report_category_id: report_categories[0].id, 
    name: 'Session Management' 
  },
  { 
    report_category_id: report_categories[0].id, 
    name: 'Password Storage'
  },
  # Data at Rest
  { 
    report_category_id: report_categories[1].id, 
    name: 'Design and Documentation'
  },
  { 
    report_category_id: report_categories[1].id, 
    name: 'Data Encryption'
  },
  { 
    report_category_id: report_categories[1].id, 
    name: 'Data Retention'
  },
  { 
    report_category_id: report_categories[1].id, 
    name: 'Data Scope'
  },
  # Data in Motion
  { 
    report_category_id: report_categories[2].id, 
    name: 'Design and Documentation'
  },
  { 
    report_category_id: report_categories[2].id, 
    name: 'Transport Encryption'
  },
  { 
    report_category_id: report_categories[2].id, 
    name: 'SSL and TLS'
  },
  { 
    report_category_id: report_categories[2].id, 
    name: 'Qualys SSL Labs Report'
  },
  # Privacy and EULA
  { 
    report_category_id: report_categories[3].id, 
    name: 'Privacy Policy'
  },
  { 
    report_category_id: report_categories[3].id, 
    name: 'End User Licence Agreement'
  },
  { 
    report_category_id: report_categories[3].id, 
    name: 'Sales and Marketing'
  },
  { 
    report_category_id: report_categories[3].id, 
    name: 'Third Parties'
  },
  { 
    report_category_id: report_categories[3].id, 
    name: 'Data Analytics'
  },
  # Disclosure
  { 
    report_category_id: report_categories[4].id, 
    name: 'Bug Bounty Program'
  },
  { 
    report_category_id: report_categories[4].id, 
    name: 'Disclosure Policy'
  },
  { 
    report_category_id: report_categories[4].id, 
    name: 'Disclosure History'
  },
  # Advertising
  { 
    report_category_id: report_categories[5].id, 
    name: 'Adverts on site'
  },
  # Incident History
  { 
    report_category_id: report_categories[6].id, 
    name: 'Public Disclosures'
  },
  {
    report_category_id: report_categories[6].id, 
    name: 'Recent Events'
  },
])

report_choices = {}
points = [-20,-10,-5,0,5,10,20]
bonuses = [false,false,false,false,true]

report_items.each do |item|
  5.times do |i|
    choice = ReportChoice.create(
        report_item_id: item.id, 
        name: "Choice #{i} for item #{item.name}", 
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut lobortis eros, at faucibus sem. Maecenas in metus iaculis, fermentum enim a",
        bonus: bonuses.shuffle.pop,
        points: points.shuffle.pop
    )
    if not report_choices.has_key? item.name
      report_choices[item.name] = []
    end

    report_choices[item.name].append choice
  end
end

services = []
10.times do |i|
  service = Service.create(
    name: "Test service #{i}",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut lobortis eros, at faucibus sem. Maecenas in metus iaculis, fermentum enim a",
    country: "us",
    hosting_provider: "Badger Inc",
    score: 0.0,
    score_updated_at: Time.at(0)
  )
  services << service
end


services.each do |service|
  report_choices.each_pair do |item, choices|
    choice = choices.shuffle.pop
    Answer.create(
      service_id: service.id,
      report_choice_id: choice.id,
      selected: true,
      notes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ut lobortis eros, at faucibus sem. Maecenas in metus iaculis, fermentum enim a"
    )
  end
end
