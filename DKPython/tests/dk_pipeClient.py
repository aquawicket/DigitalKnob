import sys
import time

# From pywin32 package:
import pywintypes
import win32file
import win32pipe


PIPENAME = "TestPipe"
TIMEOUT = 5     # seconds


print(f"Connecting to the pipe '{PIPENAME}'")
attempts = 0
while True:
    attempts += 1
    try:
        handle = win32file.CreateFile(
            fr"\\.\\pipe\{PIPENAME}",
            win32file.GENERIC_READ | win32file.GENERIC_WRITE,
            0,
            None,
            win32file.OPEN_EXISTING,
            0,
            None,
        )
    except pywintypes.error:
        if attempts >= 10:
            print("Giving up, could not connect")
            sys.exit(2)
        print("Retrying...")
        time.sleep(1)
    else:
        break
print("Connected")
win32pipe.SetNamedPipeHandleState(
    handle,
    win32pipe.PIPE_READMODE_BYTE | win32pipe.PIPE_NOWAIT,
    None,
    None,
)
data = input("Enter input: ")
data = data + "\n"
print("Sending request")
win32file.WriteFile(handle, data.encode())
print("Waiting for response")
start_time = time.monotonic()
result = ""
while True:
    try:
        status, data = win32file.ReadFile(handle, 65536)
    except pywintypes.error as e:
        error_code = e.args[0]
        error_msg = e.args[2]
        if error_code == 232:
            # 232 = "The pipe is being closed", apparently meaning that
            #   the pipe is still up but waiting for data to come
            if time.monotonic() > start_time + TIMEOUT:
                print("Timeout while waiting for result")
                break
            time.sleep(0.2)
            continue
        elif error_code in [109, 233]:
            # 109 = "The pipe has been ended"
            # 233 = "No process is on the other end of the pipe"
            # We have it all (if any)
            break
        else:
            print(
                f"Error {error_code} while trying to "
                f"read the pipe: '{error_msg}'"
            )
            break
    # We have data, handle it
    result = result + data.decode()
if result:
    print(f"Response received: '{result}'")
else:
    print("Pipe closed with no data")
win32file.CloseHandle(handle)