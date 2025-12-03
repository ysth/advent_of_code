use 5.036;
# day 3 https://adventofcode.com/2025/day/3
@ARGV = 'day3.txt' unless @ARGV;
my $joltage = 0;
while (<>) {
    chomp;
    my $battery2 = my $last_battery = chop;
    /./g;
    my $battery1 = $&;
    while (/./g) {
        if ($& gt $battery1) {
            ($battery1, $battery2) = ($&, $last_battery);
        }
        elsif ($& gt $battery2) {
            $battery2 = $&;
        }
    }
    $joltage += $battery1 . $battery2;
}
say $joltage;
