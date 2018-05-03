# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
#) end
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
  inflect.singular "families_people", "family_person"
  inflect.singular "inputs_outputs", "input_output"
  inflect.singular "address", "address"
  inflect.singular "addresses", "address"
  inflect.singular "employees_institutions", "employee_institution"
  inflect.singular "families_institutions", "family_institution"
  inflect.singular "departments_employees", "department_employee"
  inflect.singular "employees_groups", "employee_group"
  inflect.singular "employees_individual_interventions", "employee_individual_intervention"
  inflect.singular "people_houses", "person_house"
  inflect.singular "meta_print_reports_institutions", "meta_print_report_institution"
  inflect.singular "meta_print_reports_invoice_rules", "meta_print_report_invoice_rule"
  inflect.singular "people_proofs", "person_proof"
  inflect.singular "action_rules_legal_status_rules", "action_rule_legal_status_rule"
  inflect.singular "action_rules_departments", "action_rule_department"
  inflect.singular "actions_people", "action_person"
  inflect.singular "action_rule_datas", "action_rule_data"
  inflect.singular "choruses", "chorus"
  inflect.singular "choruses_invoice_rules", "choruses_invoice_rule"
  inflect.singular "choruses_infos", "choruses_info"
end
