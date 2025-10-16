# -*- mode: python -*-
from subprocess import check_output


def get_pass(email_dir: str, account_dir: str) -> str:
    """Retrieve the password for the given account name using pass."""
    command = "pass %s/%s/password" % (email_dir, account_dir)
    result = check_output(command, shell=True).strip().decode("utf-8")
    return result
