RailsAdmin.config do |config|

  config.parent_controller = '::ApplicationController'
  config.authenticate_with do
    redirect_to main_app.login_path if current_user == nil
    redirect_to main_app.root_path if !current_user.is_staff
  end
  config.current_user_method do
    current_user
  end

  RailsAdmin.config {|c| c.label_methods << :rails_admin_label}

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Answer' do
    list do
      include_all_fields
      exclude_fields :best_answer_question, :comments, :votes
    end
  end

  config.model 'Question' do
    list do
      include_all_fields
      exclude_fields :user_views, :comments, :votes, :answers, :slug
    end
  end

  config.model 'User' do
    list do
      include_all_fields
      exclude_fields :question_views, :questions, :answers, :slug
    end
  end

  config.included_models = [
    "ActsAsTaggableOn::Tag",
    "Delayed::Job",
    "Answer",
    "Comment",
    "Question",
    "UserQuestionView",
    "User",
    "Vote",
  ]
end
