use 5.036;
# day 3 https://adventofcode.com/2025/day/3
@ARGV = 'day3.txt' unless @ARGV;

my $joltage = 0;
while (my $bank = <>) {
    chomp $bank;
    my $best_batteries = top_n_batteries(12, $bank);
    $joltage += $best_batteries;
}
say $joltage;

sub top_n_batteries($n, $bank) {
    return '' unless $n;

    my $best = substr $bank, 0, 1;
    my $best_location = 0;
    for my $i (1..(length($bank) - $n)) {
        if ($best lt substr $bank, $i, 1) {
            $best = substr $bank, $i, 1;
            $best_location = $i;
        }
    }
    my $best_batteries = $best . top_n_batteries($n - 1, substr $bank, $best_location+1);
    return $best_batteries;
}
