# Capstone Project: Shell Script for AWS IAM Management

## Project Scenario

CloudOps Solutions is a growing company that recently adopted AWS to manage its cloud infrastructure. As the company scales, they have decided to automate the process of managing AWS Identity and Access Management (IAM) resources. This includes the creation of users, user groups, and the assignment of permissions for new hires, especially for their DevOps team.

## Purpose

In this capstone project, you will extend your shell scripting capabilities by creating more functions that extends the **"aws_cloud_manager.sh"** script.

## Objectives:

1. **Script Enhancement:**
   - Extend the provided script to include IAM management.

2. **Define IAM User Names Array:**
   - Store the names of the five IAM users in an array for easy iteration during user creation.

3. **Create IAM Users:**
   - Iterate through the IAM user names array and create IAM users for each employee using AWS CLI commands.

4. **Create IAM Group:**
   - Define a function to create an IAM group named "admin" using the AWS CLI.

5. **Attach Administrative Policy to Group:**
   - Attach an AWS-managed administrative policy (e.g., "AdministratorAccess") to the "admin" group to grant administrative privileges.

6. **Assign Users to Group:**
   - Iterate through the array of IAM user names and assign each user to the "admin" group using AWS CLI commands.

**Pre-requisite**
- Completion of Linux foundations with Shell Scripting mini projects

# Project Deliverables

Submit the following deliverables:
1. Comprehensive documentation detailing your entire thought process in developing the script.
2. Link to the script used for remote execution.
``` bash
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
```