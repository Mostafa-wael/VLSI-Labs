vsim -gui work.multiplier

add wave -position insertpoint  \
sim:/multiplier/A \
sim:/multiplier/B \
sim:/multiplier/P


# set the radix to Hexadecimal
radix signal sim:/multiplier/A Unsigned
radix signal sim:/multiplier/B Unsigned
radix signal sim:/multiplier/P Unsigned


# 15 × 1 = 15
force -freeze sim:/multiplier/A 1111 0
force -freeze sim:/multiplier/B 0001 0
run

# 10 × 5 = 50
force -freeze sim:/multiplier/A 1010 0
force -freeze sim:/multiplier/B 0101 0
run

# 3 * 3 = 9
force -freeze sim:/multiplier/A 0011 0
force -freeze sim:/multiplier/B 0011 0
run

# 15 * 15 = 225
force -freeze sim:/multiplier/A 1111 0
force -freeze sim:/multiplier/B 1111 0
run

# 14 * 0 = 0
force -freeze sim:/multiplier/A 1110 0
force -freeze sim:/multiplier/B 0000 0
run

# 12 * 4 = 48
force -freeze sim:/multiplier/A 1100 0
force -freeze sim:/multiplier/B 0100 0
run


