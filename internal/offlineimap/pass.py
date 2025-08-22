#!/usr/bin/env python3
from subprocess import check_output


def get_pass(account_name):
    """Retrieve the password for the given account name using pass."""
    command = "pass email/%s_pass" % account_name
    result = check_output(command, shell=True).strip().decode('utf-8')
    return result
