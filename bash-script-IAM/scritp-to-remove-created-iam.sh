#!/bin/bash

# AWS IAM Cleanup Script
# Removes IAM users and group created by the provisioning script

# Define the same IAM user names array used in creation
IAM_USERS=("dev1" "dev2" "dev3" "dev4" "dev5")
GROUP_NAME="admin"

# Function to remove users from group and delete them
delete_iam_users() {
    echo "Removing IAM users..."
    for user in "${IAM_USERS[@]}"; do
        # Remove user from group first
        aws iam remove-user-from-group \
            --group-name "$GROUP_NAME" \
            --user-name "$user" \
            && echo "Removed $user from $GROUP_NAME group" \
            || echo "Failed to remove $user from group (may not exist)"

        # Delete login profile if exists
        aws iam delete-login-profile --user-name "$user" 2>/dev/null \
            && echo "Deleted login profile for $user" \
            || echo "No login profile for $user"

        # Delete the user
        aws iam delete-user --user-name "$user" \
            && echo "Successfully deleted IAM user: $user" \
            || echo "Failed to delete IAM user: $user (may not exist)"
    done
}

# Function to detach policy and delete group
delete_admin_group() {
    echo "Cleaning up admin group..."
    # Detach the policy first
    aws iam detach-group-policy \
        --group-name "$GROUP_NAME" \
        --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess" \
        && echo "Detached AdministratorAccess policy from $GROUP_NAME group" \
        || echo "Failed to detach policy (may not exist)"

    # Delete the group
    aws iam delete-group --group-name "$GROUP_NAME" \
        && echo "Successfully deleted admin group" \
        || echo "Failed to delete admin group (may not exist)"
}

# Main execution
main() {
    # Check if AWS CLI is installed
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it first."
        exit 1
    fi

    read -p "This will delete all IAM resources created by the provisioning script. Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting cleanup."
        exit 0
    fi

    # Execute cleanup functions in reverse order of creation
    delete_iam_users
    delete_admin_group

    echo "IAM cleanup completed."
}

# Execute main function
main