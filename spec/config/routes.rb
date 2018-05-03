Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  devise_for :users, :controllers => { :sessions => "user_sessions" }

  get 'profil_writing_templates/index' => "profil_writing_templates#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  # AuthLogic
    resource :user_session
    resources :users
    resources :iris_manager_center
    #get 'login' => "user_sessions#new",      :as => :login
    #get 'logout' => "user_sessions#destroy", :as => :logout
    devise_scope :user do
      get '/login' => "user_sessions#new",      :as => :login
      get '/logout' => "user_sessions#destroy", :as => :logout
    end


    root :to => 'families_people#index'
    get 'families_people/new' => "families_people#new"
    post 'families_people/create' => "families_people#create"
    resources :town_codes
    resources :area_codes
    resources :activity_types, only: [:index]
    resources :institutions do
        collection do
          get 'choose'
          post 'choose'
          get 'hide_newsletter'
          post 'hide_newsletter'
          get 'information_theme_checklist'
        end

        member do
          get 'get_notebook_themes'
        end
    end

    resources :people do
        collection do
          get 'actions'
          get 'set_action'
          get 'choose'
        end

        member do
          get 'previous'
          get 'families_addresses'
          get 'ios'
          get 'families_members'
          get 'potential_relationships'
          get 'list_families'
          get 'list_decisions'
        end
        resources :people_proofs
        resource :national_health_service_card
        resource :bank_account_detail
        resources :administrative_informations do
          collection do
            get 'check'
            get 'family_selector'
            get 'thirdparty_selector'
          end
        end
        resources :families
        resources :documents do
          member do
            get 'download'
            get 'upload'
          end
        end
        resources :health_documents do
          member do
            get 'download'
            get 'upload'
          end
        end
        resources :jobs
        resources :schoolings do
          resources :schooling_schedules #, :as => "schedules"
        end
        resources :diplomas
        resources :relationships
        resources :law_connections
        resources :inputs_outputs, :singular => "input_output" do
          member do
            get 'duplicate'
          end
        end
        resources :foster_parent_input_outputs, :singular => "foster_parent_input_output" do
          member do
            get 'duplicate'
          end
        end
        resources :group_inputs_outputs, :singular => "group_input_output"
        resources :people_houses, :singular => "person_house" do
          member do
            get 'duplicate'
          end
        end
        resources :applications do
          member do
            get 'duplicate'
          end
        end
        resources :requests do
          member do
            get 'duplicate'
          end
        end
        resources :legal_statuses do
          collection do
            get 'duplique'
          end
        end
        resources :payments do
          collection do
            get 'history'
          end
        end
        resources :steps
        resources :follow_ups do
          member do
            get 'duplicate'
          end
        end
        resources :external_follow_ups do
          member do
            get 'duplicate'
          end
        end
        resources :individual_interventions do
          collection do
            get 'personal_notebook'
            get 'personal_notebook_theme'
            get 'export_theme'
            get 'family_notebook_theme'
            get 'export_theme_family'
          end


          member do
            get 'list_resources'
            post 'delete_interventions'
            get 'get_people_intervention'
          end

          resources :individual_intervention_guests do
            collection do
              get 'employee_selector'
              get 'thirdparty_selector'
            end
          end
        end
        resources :collective_interventions
        resources :activity_people do
          member do
            get 'edit_date'
            post 'edit_date'
            get 'edit_time'
            post 'edit_time'
          end
          collection do
            get 'fiche'
            get 'individuel'
          end
        end
        resources :information do
          collection do
            get 'fiche'
          end
        end

        resources :healths do
          collection do
            get 'fiche'
          end
        end

                resources :foreigners do
          collection do
            get 'fiche'
          end
        end

        resources :dayly_travels
        resources :plannings
        resources :movements do
          resources :travels
        end
        resources :writings do
          member do
            get 'duplicate'
            post 'duplicate'
            get 'pdf'
            get 'header'
            get 'footer'
          end
          resources :writing_tos do
            collection do
              get 'employee_selector'
              get 'thirdparty_selector'
            end
          end
        end

        resources :budgets do
          member do
            get 'details'
	  end
	end
        resources :receipts do
          collection do
            get 'analyse'
          end
        end
        resources :grids do
          member do
            get 'duplicate'
            post 'duplicate'
          end
        end
    end

    resources :budget_types, :only => [:new, :create]
    resources :budget_themes, :only => [:new, :create]
    resources :budget_items, :only => [:new, :create]
    resources :budget_lines, :only => [:create, :edit, :update, :destroy]

    resources :individual_interventions do
        collection do
          get 'analyse'
          get 'update_rapide'
          get 'list_interventions'
          get 'export'
          post 'paste_day'
          post 'paste_week'
          get 'destroy_list'
          post 'destroy_list'
          post 'destroy_all'
          post 'destroy_all_people'
          post 'print'
        end

        member do
          post 'toggle'
          get 'people_for_intervention'
          get 'json'
        end
    end

    resources :collective_interventions do
        collection do
          get 'analyse'
          get 'update_rapide'
          get 'list_interventions'
          get 'export'
          get 'show_activity'
          post 'update_collective_interventions'
          get 'show_time'
          post 'destroy_list'
        end

        member do
          post 'toggle'
        end
    end

    resources :pictures
    resources :families do
        member do
          get 'addresses'
        end

        resources :people
    end

    resources :families_institutions, :singular => "family_institution"
    resources :families_people do
        collection do
          get 'fratrie'
        end

        resource :family
        resource :person
    end

    resource :advanced_search do
        collection do
          get 'export'
	  get 'show'
	  post 'show'
        end
    end

    resource :les_presents do
        collection do
          get 'new'
          post 'new'
          get 'export'
          post 'export'
        end
    end

    resource :piloting do
        collection do
          get 'activity'
          get 'application'
          get 'motions'
          get 'steps'
          get 'finance'
          get 'finance_comptable'
          get 'payments'
          get 'financels'
          get 'interventions'
          get 'activity_mei'
          get 'repartition_mei'
          get 'effectif'
        end
    end

    resource :clipboard, :controller => "clipboard"
    resource :planning do
        collection do
          get 'intervenant'
        end
    end

    resources :institutions do
        member do
          get 'header'
          get 'footer'
        end

        collection do
          post 'choose'
          get 'choose'
          post 'hide_newsletter'
          get 'hide_newsletter'
        end

        resource :bank_account_detail
        resource :meta_print_reports_institutions, :only => [:show, :create] do
                post 'duplicate'
        end
        resource :meta_print_reports_invoice_rules, :only => [:show]
    end

    resources :selectors do
        collection do
          delete 'destroy_all'
        end
    end

    resources :houses do
        collection do
          get 'search'
        end
    end

    resources :people_houses do
        collection do
          get 'manager'
        end

        member do
          post 'toggle'
        end
    end

    resources :automatic_invoicing do
        collection do
          put 'validate'
          get 'prepare'
          get 'single'
        end
    end

    resources :automatic_assfam_invoicing do
        collection do
          get 'prepare'
          get 'redo'
          post 'redo'
        end
    end

    resources :redo_invoicing do
        collection do
          post 'recalcul'
        end
    end

    resources :edi_out do
        collection do
          get 'display_edi'
          post 'print'
          post 'delete'
          post 'envoi'
        end
    end

    resources :edi_in do
        collection do
          post 'update_return'
        end
    end

    resources :edi_reject do
        member do
          get 'details'
        end

        collection do
          post 'update_rejet'
          post 'traiter'
        end
    end

    resources :manual_invoicing

    get '/invoice_headers/print' => "invoice_headers#print"
    get '/invoice_emp_headers/print' => "invoice_emp_headers#print"
    post '/invoice_emp_headers/print' => "invoice_emp_headers#print"
    delete '/invoice_emp_headers/destroy_list'  => "invoice_emp_headers#destroy_list"

    resources :invoice_headers do
        collection do
          get 'validate_list'
          post 'validate_list'
          get 'search'
          get 'search_json'
        end

        member do
          get 'details'
          put 'validate'
          post 'validate'
          get 'update_info'
          get 'destroy'
          delete 'destroy'
          get 'destroy_all_lines'
        end
        resources :invoice_lines do
          member do
            get 'delettrer'
          end
        end
    end

    resources :recall_rates do
        collection do
          get 'rappel'
        end
    end

    resources :health_themes do
        resources :health_items
    end

        resources :foreigner_themes do
      # pour la creation des listes déroulantes
          collection do
            post 'create_foreigner_item'
            post 'create_foreigner_status'
	    get 'new_foreigner_item'
	    get 'new_foreigner_status'
          end
          member do
            get 'check'
            delete 'destroy_foreigner_item'
            get 'edit_foreigner_item'
            put 'update_foreigner_item'
            delete 'destroy_foreigner_status'
            get 'edit_foreigner_status'
            put 'update_foreigner_status'
          end
        resources :foreigner_items
        end

    resources :labels , :id => /.+/
    resources :groups do
        collection do
          post 'choose'
        end
    end

    resources :departments do
        collection do
          post 'update_archived_at'
          post 'update_list_people'
          get 'list'
          get 'get_groups'
        end

        member do
          get 'foster_parent'
          get 'check_previsionnal_outgoing'
          get 'rules'
          get 'application_service'
      get 'motifs_admission_1'
      get 'motifs_admission_2'
      get 'motifs_admission_3'
      get 'motifs_admission_4'
      get 'motifs_admission_5'
      get 'motifs_going_1'
      get 'motifs_going_2'
      get 'motifs_going_3'
      get 'motifs_going_4'
      get 'motifs_going_5'
          post 'update_date_validation_calendar'
      get 'header'
      get 'footer'
          get 'io_type_ok'
        end

        resources :groups
        resource :bank_account_detail
        resources :department_timings
    end
 # deb 21/04/2015
    resources :inputs_outputs  do
          collection do
              post 'update_date_validation_calendar'
          end
    end
 # fin 21/04/2015

    resources :foster_parent_input_outputs  do
          collection do
              post 'update_date_validation_calendar'
          end
    end

    resources :individual_intervention_rules do
        member do
          get 'check_display'
        end
    end

    resources :group_inputs_outputs, :singular => "group_input_output" do
        collection do
          post 'create_from_group'
        end
    end

    get '/help' => "help#index"
    get '/settings' => "settings#index"
    delete '/settings/remove_label_cache' => "settings#remove_label_cache"
    delete '/settings/remove_calendar_cache' => "settings#remove_calendar_cache"
    get '/reload' => "reload#index"

    namespace :bo do
        resources :users
        resources :institutions
        resources :third_parties do
          collection do
            get 'export'
          end
        end
        resources :employees do
          collection do
            get 'foster_parent'
            get 'lite_search'
            get 'search_foster_parent'
            get 'export'
          end

          resources :foster_parent_families
          resources :foster_parent_agreements
          resources :foster_parent_trainings
          resources :foster_parent_synthesises
          resources :foster_parent_iks do
            collection do
              get 'history'
            end
          end
          resources :foster_parent_specificities
          resource :user
          resources :foster_parent_proofs
        end
        resources :foster_parent_proofs do
          member do
                post 'change_status_proof'
                get 'change_status_proof'
          end
        end
        resources :employees_institutions
        resources :departments_employees
        resources :employees_groups
        resources :rights do
          collection do
            get 'new_profil'
            post 'new_profil'
          end
          member do
            post 'toggle'
          end
        end

        resources :profils do
          resources :rights do
            collection do
              get 'duplicate'
              post 'duplicate'
              get 'copy'
              post 'copy'
              get 'reset'
              delete 'destroy_profil'
            end
            member do
              post 'toggle'
            end
          end
          resources :profil_menu_items do
            collection do
              post 'change_order'
              post 'change_status'
            end
          end

          resources :profil_action_items do
            collection do
              post 'change_status'
            end
          end
          resources :notebook_theme_profils do
            collection do
              post 'change_status'
              get 'manage'
            end
          end
          resources :profil_writing_templates do
            collection do
              post 'change_status'
            end
          end

        end
        resources :notebook_themes
        resources :proofs

        # datas
        resources :activity_codes
        resources :activity_types
        resources :administrative_information_types
        resources :area_codes
        resources :countries
        resources :diploma_codes
        resources :diploma_types
        resources :forms
        resources :job_codes
        resources :job_types
        resources :languages
        resources :legal_status_answer_rules
        resources :marital_statuses
        resources :payment_types
        resources :results
        resources :student_types
        resources :third_party_types
        resources :institution_individual_card_settings
        resources :institution_family_card_settings
        resources :foster_parent_card_settings
        resources :payments do
            get 'check'
        end

        # adresse ip autorisée par étab
        resources :institution_ip_alloweds
    end

    resources :movements, :except => [:destroy] do
        collection do
          get 'collective'
          get 'day_details'
          get 'day_details_json'
          get 'quick_add'
          get 'quick_fpio_add'
          get 'presence'
          get 'foster_parent_input_output'
          get 'fiches_de_sorties'
          get 'analyse'
          get 'list_movements'
          get 'export'
          post 'supprimer_list'
          get 'collective_week'
        end
    end

    resources :print_reports do
        collection do
          get 'report_list'
          post 'report_list'
        end

        member do
          get 'report_details'
        end
    end

    resources :report_activities do
        collection do
          get 'achieved'
          get 'demand'
          get 'admission'
          get 'output'
          get 'followed'
          get 'intervention'
          get 'population'
          get 'association'
          get 'cmpp'
          get 'payment'
          get 'externalconsulting'
          get 'consolidate'
          get 'consolidate_activity'
          get 'parameters'
          get 'perimeter'
          get 'suivi'
          get 'list_perimeter'
        end
    end

    resource :healths do
        collection do
          get 'analyse'
          get 'list_healths'
          get 'export'
        end
    end

    resources :document_people do
        collection do
          get 'analyse'
        end
    end
    resources :health_document_people
    resources :writing_infos do
        member do
          get 'check'
        end
    end
    resources :intervention_statuses
    resources :writing_statuses
    resources :writing_templates do
        collection do
          post 'add_theme'
          post 'add_item'
        end

        member do
          get 'delete_theme'
          get 'delete_item'
        end
    end

    resources :emailer do
        collection do
          post 'sendmail'
        end
    end

    resource :document_selects_controls do
        collection do
          get 'doc_type_select'
          get 'doc_type_checklist'
        end
    end

    resource :health_document_selects_controls do
        collection do
          get 'doc_type_select'
          get 'doc_type_checklist'
        end
    end
    # collection => /movement_rules/get_value_fuge?id=
        # member => /movement_rules/id/get_value_fuge
        resources :movement_rules do
        member do
          get 'get_value_fuge'
        end
        end

    resources :numero_insees, :only => [:index]
    resources :gruff do
        collection do
          get 'pie'
          get 'bar'
          get 'spider'
          get 'net'
        end
    end

    resources :activities do
        member do
              get 'duplicate'
        end
        resources :activity_employees
        resources :activity_timings
    end

    resources :activity_people do
        collection do
          post 'valid_inscriptions'
          post 'add_periods'
        end
    end

    resources :department_rules do
        collection do
          post 'generate_exercise'
        end
    end

    resources :financial_departments do
        member do
          get 'rules'
          get 'ls_rules'
        end

        resources :financial_department_rules do
          collection do
            post 'generate_exercise'
          end
        end
    end

    resources :department_financial_departments
    resources :invoice_rule_financial_departments
    resources :information do
        collection do
          get 'analyse'
        end
    end

    resources :line_counting_price_rules do
        member do
          post 'generate_next'
          post 'update_form'
        end
    end

    resources :housing_informations do
        collection do
          get 'export'
        end
    end

    resources :ic_files do
        collection do
          post 'sendfile_to'
          post 'search'
          post 'print'
        end
    end

    resources :notebooks do
        collection do
          get 'get_towards'
          get 'get_toward_type'
          get 'export'
        end

        member do
          get 'complete'
        end
    end

    resources :ik_rules do
          collection do
            post 'generate_exercise'
                get 'any_ik_payments'
                get 'reset_fp_iks'
          end
        end
    resources :warning_contents do
        collection do
          get 'export'
        end
    end
    resources :third_parties do
      collection do
        get 'search'
      end
    end
    resources :special_day_dates
    resources :calendar_rules, only: [:index]
    resources :payment_rules do
        member do
          get 'check'
        end
    end
    resources :receipts do
        collection do
          get 'assign'
          get 'recall'
          post 'print'
        end

        member do
          get 'delettrer'
          get 'update_rest_of_money'
        end
    end
    resources :receipt_invoices do
        collection do
          get 'delettrer'
        end
    end
    resources :perimeters do
        member do
                get 'duplicate'
                post 'duplicate'
        end
    end
    resources :meta_print_reports do
        collection do
          get 'search_rapport'
          post 'search_rapport'
        end
        member do
                get 'check_attachments'
        end
    end
    resources :meta_print_report_first_attachments
    resources :meta_print_report_second_attachments
    resources :meta_print_reports_institutions do
        member do
                post 'change_status'
        end
    end
    resources :meta_print_reports_invoice_rules
    resources :people_proofs do
        member do
                post 'change_status_proof'
                get 'change_status_proof'
        end
    end
    resources :invoice_rules
    resources :invoice_emp_headers do

        collection do
          post 'validate_list'
          get 'search'
          get 'search_json'
        end

         member do
          get 'details'
          put 'validate'
          post 'validate'
          get 'update_info'
          get 'destroy'
          delete 'destroy'
          get 'destroy_all_lines'
        end

        resources :invoice_emp_lines
    end
    resources :invoice_emp_lines
    resources :accounting_years
    resources :hr_work_contract_codes
    resources :hr_function_codes
    resources :hr_civilities
    resources :hr_institutions
    resources :movement_supplementaries_templates do
        collection do
          get 'institutions_sans_template'
          get 'duplique'
        end
    end
        resources :favorites
        resources :user_favorites do
                collection do
                  post 'user_favorite_page'
                end
        end

    resources :grid_types do
        resources :information_themes do
            resources :information_items
        end
    end

        resources :information_scores

    resources :action_rules do
                collection do
                  get 'schedule'
                  get 'list'
                  get 'export'
                end
                resources :action_rules_legal_status_rules
                resources :action_rules_departments
        end

    resources :action_data

    resources :meta_writing_functions
    resources :guides, :only => [:index, :show]
    resources :choruses
    resources :choruses_infos do
      member do
        get 'generate_exercise'
      end
    end
    
    resources :answers do
      member do
        get 'answer_type_position'
      end
    end
    resources :ransack_multiselects
end
