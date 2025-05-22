#!/usr/bin/env python3

import os
import sys
import glob
import time
import signal
import subprocess

g_shutdown = False
#usleep = lambda x: time.sleep(x/1000000.0)

def signal_handler(sig, frame):
	global g_shutdown
	g_shutdown = True
	os.system('pkill openvpn')

def blocking_launch_holding_output_until_exit(f):
	print(f'\nRunning /app/connect.sh {f} ...')
	result = subprocess.run(['/app/connect.sh', f], capture_output=True, text=True)
	print(result.stdout)

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

if __name__ == "__main__":
#	os.chdir('/profiles')

	signal.signal(signal.SIGINT,  signal_handler)
	signal.signal(signal.SIGTERM, signal_handler)
	signal.signal(signal.SIGQUIT, signal_handler)

	while not g_shutdown:
		ovpn_profiles_list = glob.glob('/profiles/*.ovpn')
		for f in ovpn_profiles_list:
			blocking_launch(f)
			simple_wait()
