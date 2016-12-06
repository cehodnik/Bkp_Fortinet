# Bkp_Fortinet
Script for Backup Fortinet Scheduled.
Enable SCP

Using the CLI:

config system global
  set admin-scp enable
end
Enable SSH access on the interface

SCP uses SSH protocol to provide secure file transfer. The interface you use for administration must allow SSH access.

Using the Web-based manager:

Go to System > Network > Interface.

Select the Edit icon for the interface you use for administrative access.

In the Administrative Access section, select the SSH check box.

Select OK.

Using the CLI:

Enter show system interface<interface name>
and note the allowaccess setting, e.g.: ping https

Add ssh to the allowaccess setting:

config system interface
  edit <interface name>
    set allowaccess ping https ssh
  end
  
SCP authenticates itself to the FortiGate unit in the same way as an administrator using SSH to access the CLI. Instead of using a password, you can configure the SCP client and the FortiGate unit with a public-private key pair.
To configure public-private key authentication

Create a public-private key pair using a key generator tool compatible with your SCP client.

Save the private key to the location on your computer where your SSH private keys are stored.
This step depends on your SCP product. The SSH Secure Shell key generator automatically stores the private key. In the PuTTY Key Generator, you must manually save the private key.

Copy the public key to the FortiGate unit. You do this in the FortiGate CLI, as follows:

Enter:
config system admin
  edit admin
    set ssh-public-key1 "<key-type> <key-value>"
<key-type> must be ssh-dss for a DSA key or ssh-rsa for an RSA key. For <key-value>, you must copy the public key data and paste it into the CLI command.

If you are copying the key data from Windows Notepad, observe the following so that you copy the key data correctly:

Copy one line at a time and make sure that you paste each line of key data at the end of the previously pasted data.
Do not copy the end-of-line characters that appear as small rectangles in Notepad.
Do not copy the ---- BEGIN SSH2 PUBLIC KEY ---- or Comment: "[2048-bit dsa,...]" lines.
Do not copy the ---- END SSH2 PUBLIC KEY ---- line.
Type the closing quotation mark and press Enter.

Enter the end command.

Your SCP client can now authenticate to the FortiGate unit based on SSH keys instead of an administrator password.
