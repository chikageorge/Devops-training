#!/bin/bash

# AWS IAM Management Script
# Extends aws_cloud_manager.sh to handle IAM user and group management

# Define IAM user names array
IAM_USERS=("dev1" "dev2" "dev3" "dev4" "dev5")

# Function to create IAM users
create_iam_users() {
    echo "Creating IAM users..."
    for user in "${IAM_USERS[@]}"; do
        aws iam create-user --user-name "$user"
        if [ $? -eq 0 ]; then
            echo "Successfully created IAM user: $user"
        else
            echo "Failed to create IAM user: $user"
        fi
    done
}

# Function to create admin group
create_admin_group() {
    echo "Creating admin group..."
    aws iam create-group --group-name "admin"
    if [ $? -eq 0 ]; then
        echo "Successfully created admin group"
    else
        echo "Failed to create admin group"
    fi
}

# Function to attach admin policy to group
attach_admin_policy() {
    echo "Attaching AdministratorAccess policy to admin group..."
    aws iam attach-group-policy \
        --group-name "admin" \
        --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess"
    if [ $? -eq 0 ]; then
        echo "Successfully attached AdministratorAccess policy"
    else
        echo "Failed to attach AdministratorAccess policy"
    fi
}

# Function to add users to admin group
add_users_to_group() {
    echo "Adding users to admin group..."
    for user in "${IAM_USERS[@]}"; do
        aws iam add-user-to-group \
            --group-name "admin" \
            --user-name "$user"
        if [ $? -eq 0 ]; then
            echo "Successfully added $user to admin group"
        else
            echo "Failed to add $user to admin group"
        fi
    done
}

# Main execution
main() {
    # Check if AWS CLI is installed
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it first."
        exit 1
    fi

    # Execute IAM management functions
    create_iam_users
    create_admin_group
    attach_admin_policy
    add_users_to_group

    echo "IAM management completed."
}

# Execute main function
main