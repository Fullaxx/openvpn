#!/usr/bin/env python3

import os
import sys
import glob
import time
import random
import signal
import subprocess

g_shutdown = False
g_randomize = False
#usleep = lambda x: time.sleep(x/1000000.0)

def signal_handler(sig, frame):
	global g_shutdown
	g_shutdown = True
	os.system('pkill openvpn')

#def blocking_launch_holding_output_until_exit(f):
#	print(f'\nRunning /app/connect.sh {f} ...')
#	result = subprocess.run(['/app/connect.sh', f], capture_output=True, text=True)
#	print(result.stdout)

def blocking_launch(f):
	if g_shutdown: return
	print(f'\nRunning /app/connect.sh {f} ...')
	with subprocess.Popen(
		['/app/connect.sh', f],
		stdout=subprocess.PIPE,
		stderr=subprocess.STDOUT,  # Optional: combines stderr with stdout
		text=True,  # Automatically decodes bytes to string
		bufsize=1   # Line-buffered
	) as process:
		for line in process.stdout:
			print(line, end='')  # Already includes newline

def simple_wait():
	if g_shutdown: return
	print('sleep 1 ..')
	time.sleep(1)

def get_profile_list():
	ovpn_profiles_list = glob.glob('/profiles/*.ovpn')
	if g_randomize:
		random.shuffle(ovpn_profiles_list)  # Modifies in place
	return ovpn_profiles_list

def acquire_environment():
	global g_randomize

	random_env_var = os.getenv('RANDOMIZE_PROFILE_LIST')
	if random_env_var is not None:
		flags = ('1', 'y', 'Y', 't', 'T')
		if (random_env_var.startswith(flags)): g_randomize = True
		if (random_env_var == 'on'): g_randomize = True
		if (random_env_var == 'ON'): g_randomize = True

if __name__ == "__main__":
	acquire_environment()
#	os.chdir('/profiles')

	signal.signal(signal.SIGINT,  signal_handler)
	signal.signal(signal.SIGTERM, signal_handler)
	signal.signal(signal.SIGQUIT, signal_handler)

	while not g_shutdown:
		for f in get_profile_list():
			blocking_launch(f)
			simple_wait()
