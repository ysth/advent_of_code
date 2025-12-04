use 5.036;
use List::Util 'min', 'max';
# day 3 https://adventofcode.com/2025/day/3
@ARGV = 'day3.txt' unless @ARGV;

my $batteries = 12;
my $joltage = 0;

while (my $bank = <>) {
    chomp $bank;
    my $best_batteries =  '';
    while ($bank =~ /./g) {
        # can we replace some battery with this or add it?
        # toward the end of the string, we can only make changes for later batteries
        for my $position (max(0,$batteries+pos($bank)-length($bank)-1)..min($batteries-1,length $best_batteries)) {
            if ($& gt substr $best_batteries, $position, 1) {
                substr $best_batteries, $position, length($best_batteries) - $position, $&;
                last;
            }
        }
    }
    $joltage += $best_batteries;
}
say $joltage;
