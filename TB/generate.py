import struct
import random

# Generate random array of floating-point numbers
random_array = [random.uniform(-1000, 1000) for _ in range(32)]
hexadecimal  = []
print(random_array)
# Convert each number to IEEE-754 32-bit format and print in hexadecimal
for num in random_array:
    # Convert to binary representation
    binary = struct.pack('!f', num)

    # Convert binary to hexadecimal
    hexadecimal = ''.join(f'{byte:02x}' for byte in binary)

    print(hexadecimal)
