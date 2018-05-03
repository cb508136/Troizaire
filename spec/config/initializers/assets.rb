# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.3'

# Add additional assets to the asset load path
#Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

###################### CSS ######################
Rails.application.config.assets.precompile += %w(
  ad_search.css
  admin_data.css
  adminlte/plugins/fullcalendar/fullcalendar.css
  adminlte/plugins/fullcalendar/fullcalendar.print.css
  application.css
  budget.css
  calendar_print.css
  colorPicker.css
  ecrit_pdf_landscape.css
  ecrit_pdf_portrait.css
  edit_employee.css
  ecrit.css
  pdf.css
  print.css
  print_css.css
  print_ecrits.css
  print_popup.css
  right_click_menu.css
  scroll_table.css
  writing_ifoverlay_landscape.css
  writing_ifoverlay_portrait.css
)

####################### JS ######################
Rails.application.config.assets.precompile += %w(
  duplication.js
  tiny_mce.js
  tiny_mce_init.js
  verif_insee.js
)
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
