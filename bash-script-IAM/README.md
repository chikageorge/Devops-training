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