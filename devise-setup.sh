#!/bin/bash

# Get model name from user input or use default value
read -p "Enter model name (default: User): " USER_MODEL
USER_MODEL=${USER_MODEL:-User}

USER_MODEL_FILENAME = $(echo "$USER_MODEL" | tr '[:upper:]' '[:lower:]')
# Define variables
USER_MODEL_FILE="app/models/$USER_MODEL_FILENAME.rb"
ROUTES_FILE="config/routes.rb"
# Install Devise gem
echo "Installing Devise gem..."
echo "gem 'devise'" >> Gemfile
bundle install
rails generate devise:install
# Generate User model with Devise
echo "Generating $USER_MODEL model with Devise..."
rails generate devise $USER_MODEL
rails db:migrate
rails generate devise:views
# Modify User model with custom validation
echo "Modifying $USER_MODEL model with custom validation..."
cat << EOF > $USER_MODEL_FILE
class $USER_MODEL < ApplicationRecord
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
EOF


# Check if the ApplicationController already contains Devise configuration
if grep -q "before_action :authenticate_$(echo "${USER_MODEL}" | tr '[:upper:]' '[:lower:]')" app/controllers/application_controller.rb
then
    echo "ApplicationController already contains Devise configuration"
else
    # Add Devise configuration to the ApplicationController
    cat << EOF > "app/controllers/application_controller.rb"
class ApplicationController < ActionController::Base
  before_action :authenticate_$(echo "${USER_MODEL}" | tr '[:upper:]' '[:lower:]')!
end
EOF
    echo "Added Devise configuration to ApplicationController"
fi

echo "Done!"
