#!/usr/bin/env python3
import argparse
import subprocess
import pwd
import socket
import os

ADMIN_USER = "hackerspace_admin"
ADMIN_UID = pwd.getpwnam(ADMIN_USER).pw_uid
RANGE_START = 1
RANGE_END = 2

def ssh_fingerprint_changed(node):
    """
    Checks if a node's ssh fingerprint has changed or an old key is found, which can occur when a node is reimaged.
    It does this by attempting to connect via ssh and inspecting stdout for an error message.
    :param node: the ip or hostname of the node
    :return: True if the node's fingerprint doesn't match the client's records. Else False.
    """
    changed = False
    cmd = ["ssh", "-q", ADMIN_USER + "@" + node, "exit"]
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stdin=subprocess.PIPE, universal_newlines=True)
    for line in proc.stdout:  # loop on lines
        print("in for loop")
        if b"Offending key" in line:
            print("Offending key found.")
            proc.stdin.write(b"no\n")   # don't connect
            changed = True
        elif b"REMOTE HOST IDENTIFICATION HAS CHANGED!" in line:
            print("REMOTE HOST IDENTIFICATION HAS CHANGED!")
            changed = True

    print(changed)
    if not changed:  # then everything's good, but it will be waiting for a password to connect
        print("Good to go, terminating ssh test.")
        rc = proc.terminate()
    else:
        rc = proc.wait()

    print(changed)
    return changed


def remove_ssh_fingerprint(node):
    """
    Removes a node's public key fingerprint from the client's records
    :param node: the ip or hostname of the node
    :return:
    """
    cmd = ["ssh-keygen", "-R", node]
    completed = subprocess.run(cmd, stdout=subprocess.PIPE, universal_newlines=True)
    print(completed.stdout)


def ssh_fingerprint_exists(node):
    """
    Looks for a node's ssh fingerprint
    :param node: the ip or hostname of the node
    :return: True if the node's fingerprint was found on the client. Else False.
    """
    cmd = ["ssh-keygen", "-F", node]
    completed = subprocess.run(cmd, stdout=subprocess.PIPE, universal_newlines=True)
    if completed.stdout == "":
        return False
    return True


def get_ssh_fingerprints(node):
    """
    Retrieves a node's ssh key fingerprints.
    :param node: the ip or hostname of the node
    :return: the node's fingerprints as a string.
    """
    cmd = ["ssh-keyscan", "-H", node]
    completed = subprocess.run(cmd, stdout=subprocess.PIPE, universal_newlines=True)
    fingerprints = completed.stdout
    return fingerprints


def add_ssh_fingerprints_to_client(fingerprints):
    """
    Records the provided fingerprints in ~/.ssh/known_hosts
    :param fingerprints: public ssh key fingerprints
    :return:
    """
    filename = os.path.expanduser("~/.ssh/known_hosts")
    with open(filename, "a") as known_hosts:
        known_hosts.write(fingerprints)
        known_hosts.write("\n")
    print("New host fingerprint added")


def repair_fingerprints(hostname, force=False):
    print("\n\n######################################################")
    print("HOSTNAME: " + hostname)
    # Is the node reachable?
    try:
        ip = socket.gethostbyname(hostname)
    except OSError as e:
        print("Skipping: " + hostname)
        print(e)
        return
    print("IP: " + ip)

    # Do we already have a fingerprint for the node?
    keys_exist = ssh_fingerprint_exists(hostname)
    print("KEYS EXIST: " + str(keys_exist))

    # Has the fingerprint changed? (happens if the node was reimaged)
    keys_changed = True if force else ssh_fingerprint_changed(hostname)

    if keys_changed:
        # if so, remove the client's record.  There may be multiple, so continue until all are removed
        print("KEYS CHANGED or FORCE REFRESH: Attempting to remove the old fingerprints...")
        remove_ssh_fingerprint(hostname)
        remove_ssh_fingerprint(ip)

    if not keys_exist or keys_changed:
        keys = get_ssh_fingerprints(hostname)
        print("KEYS: Adding new fingerprints")
        add_ssh_fingerprints_to_client(keys)

    else:
        print("Public key fingerprint match. Good!")


if __name__ == "__main__":  # if this script is run form the command line
    parser = argparse.ArgumentParser()
    parser.add_argument("-n", "--number", type=int, help="Number: to repair a specific student node: tbl-hackerspace-#-s")
    parser.add_argument("--hostname", help="The node's ip or hostname")
    parser.add_argument("-f", "--force", action="store_true", help="Don't check for problems, just force reset of fingerprints")
    args = parser.parse_args()

    start_node = args.number if args.number else RANGE_START
    end_node = args.number if args.number else RANGE_END
    force = args.force
    hostname = args.hostname

    if hostname:
        repair_fingerprints(hostname, force)
    else:
        for x in range(start_node, end_node+1):
            hostname = "tbl-hackerspace-{x}-s".format(**locals())
            repair_fingerprints(hostname, force)

