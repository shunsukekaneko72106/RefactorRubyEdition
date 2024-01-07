# マジックナンバーからシンボル定数へ
# 定数を作り、意味に基づいて名前を与え、数値の代わりに使う

# Before
def potential_energy(mass, height)
  mass * 9.81 * height
end

# After
GRAVITATIONAL_CONSTANT = 9.81

def potential_energy(mass, height)
  mass * GRAVITATIONAL_CONSTANT * height
end