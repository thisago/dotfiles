#!/usr/bin/env python3
import commands


# def get_pass(account_name):
#     """Retrieve the password for the given account name using pass."""
#     command = "pass email/%s_pass" % account_name
#     print("Executing command:", command)
#     return check_output(command).strip().decode('utf-8')

def get_pass(account_name):
    cmd = "pass email/%s_pass" % account_name
    (status, output) = commands.getstatusoutput(cmd)
    return output.strip().decode('utf-8')

get_pass("example_account")  # Replace with the actual account name you want to retrieve
